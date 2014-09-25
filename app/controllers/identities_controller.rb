require 'signed_message'

# Handles user-contributed content
class IdentitiesController < ApplicationController
  class InvalidRequest < NoMethodError; end
  class RequestDenied  < NoMethodError; end

  rescue_from InvalidRequest do |exception|
    reply exception.message, status: :bad_request
  end

  rescue_from RequestDenied do |exception|
    reply exception.message, status: :forbidden
  end

  def update
    message = case params[:command]
              when ActionDispatch::Http::UploadedFile then params[:command].read
              when String then params[:command]
              end
    slug = params[:slug]

    command, fingerprint = signed_command(message)

    case command
    when 'disable'
      request_disable(slug, fingerprint)
    when 'enable'
      request_enable(slug, fingerprint)
    else
      fail InvalidRequest, "Unknown command: #{ command.inspect }"
    end
  end

  def show
    slug = params[:slug]

    @identity = Identity.find_by_slug!(slug)

    expires_in 1.year, public: true
  end

  private

  def request_disable(slug, fingerprint)
    identity = Identity.find_by_slug(slug)

    if identity
      if identity.key.fingerprint == fingerprint
        identity.destroy
        reply "Disabled alias: #{slug}", status: :ok
      else
        fail RequestDenied, 'Permission denied.'
      end
    else
      fail RequestDenied, 'Not enabled.'
    end
  end

  def request_enable(slug, fingerprint)
    identity = Identity.new(slug: slug, fingerprint: fingerprint)

    if Trust.call(identity)
      if identity.save
        reply "Enabled alias: #{slug}", status: :created
      else
        if identity.errors[:slug].include?('has already been taken')
          fail RequestDenied, 'Already enabled.'
        elsif identity.errors[:fingerprint].include?('has already been taken')
          fail RequestDenied, 'You may only enable one alias.'
        else
          fail RequestDenied, 'Permission denied.'
        end
      end
    else
      fail RequestDenied, 'Sorry, this key is not yet trusted.'
    end
  end

  def signed_command(message)
    signed_message = SignedMessage.new(message)

    if signed_message.valid?
      command = signed_message.body.to_s.chomp.downcase

      return [command, signed_message.fingerprint]
    else
      fail InvalidRequest, 'Invalid signature.'
    end
  end

  def reply(message, **options)
    render text: "#{ message }\n", **options
  end
end
