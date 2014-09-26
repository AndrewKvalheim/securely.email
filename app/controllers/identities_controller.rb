require 'signed_message'
require 'status'

# Handles user-contributed content
class IdentitiesController < ApplicationController
  class InvalidRequest < NoMethodError; end
  class RequestDenied  < NoMethodError; end

  rescue_from InvalidRequest do |exception|
    reply exception.message, status: :bad_request
  end

  def update
    slug = params[:slug]
    command, fingerprint = signed_command(allow_file(params[:command]))

    status = case command
             when 'disable' then DisableIdentity.call(slug, fingerprint)
             when 'enable'  then EnableIdentity.call(slug, fingerprint)
             else Failure.new type: :bad_request,
                              message: "Unknown command: #{ command.inspect }"
             end

    reply status.message, status: status.type
  end

  def show
    slug = params[:slug]

    @identity = Identity.find_by_slug!(slug)

    expires_in 1.year, public: true
  end

  private

  def allow_file(param)
    case param
    when ActionDispatch::Http::UploadedFile then param.read
    when String then param
    end
  end

  def signed_command(data)
    message = SignedMessage.new(data)
    fail InvalidRequest, 'Invalid signature.' unless message.valid?

    [message.body.to_s.chomp.downcase, message.fingerprint]
  end

  def reply(message, **options)
    render text: "#{ message }\n", **options
  end
end
