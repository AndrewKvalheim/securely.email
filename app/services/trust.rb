require 'service'

# Determines trust of an identity using the web of trust
class Trust
  EXAMPLE   = '81A46DCA7018FABFC72BB787253A0338239BC6E9'
  REFERENCE = 'B80C4E1E6F5544B277518173535B253E3B5AB9C6'
  WOTSAP = Rails.root.join('wotsap').to_s

  include Service

  def call(identity)
    connected_to?(identity.fingerprint)
  end

  private

  def connected_to?(fingerprint)
    # FIXME: Mock
    return true if Rails.env.test? && fingerprint == EXAMPLE

    Rails.cache.fetch("/wot/#{ fingerprint }", expires_in: 1.day) do
      from = REFERENCE[-8..-1]
      to   = fingerprint[-8..-1]

      system(WOTSAP, from, to, err: File::NULL, out: File::NULL)
    end
  end
end
