require 'service'

# Disable an identity
class DisableIdentity
  include Service

  def call(slug, fingerprint)
    identity = Identity.find_by_slug(slug)

    unless identity
      return Failure.new(type: :forbidden, message: 'Not enabled.')
    end

    unless identity.key.fingerprint == fingerprint
      return Failure.new(type: :forbidden, message: 'Permission denied.')
    end

    fail unless identity.destroy

    message = if Invalidate.call(slug).success?
                "Disabled alias: #{slug}"
              else
                "Disabled alias: #{slug} (May take several days to update.)"
              end

    Success.new type: :ok, message: message
  end
end
