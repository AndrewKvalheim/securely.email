require 'service'
require 'status'

# Enable an identity
class EnableIdentity
  include Service

  def call(slug, fingerprint)
    fail RequestDenied, 'Untrusted key.' unless Trust.call(fingerprint)

    create_identity(slug, fingerprint)
  end

  private

  def create_identity(slug, fingerprint)
    identity = Identity.new(slug: slug, fingerprint: fingerprint)

    if identity.save
      Success.new type: :created, message: "Enabled alias: #{slug}"
    else
      # FIXME: Use original messages.
      taken = 'has already been taken'
      message = if identity.errors[:slug].include?(taken)
                  'Already enabled.'
                elsif identity.errors[:fingerprint].include?(taken)
                  'You may only enable one alias.'
                else
                  'Permission denied.'
                end

      Failure.new type: :forbidden, message: message
    end
  end
end
