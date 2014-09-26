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

    Success.new type: :ok, message: "Disabled alias: #{slug}"
  end
end
