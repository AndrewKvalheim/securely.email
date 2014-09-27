require 'service'
require 'status'

# Determines trust of an identity using the web of trust
class Trust
  WOTSAP = Rails.root.join('wotsap').to_s

  include Service

  def call(fingerprint)
    if connected_to?(fingerprint)
      Success.new
    else
      Failure.new
    end
  end

  private

  def connected_to?(fingerprint)
    Rails.cache.fetch("/wot/#{ fingerprint }", expires_in: 1.day) do
      from = REFERENCE[-8..-1]
      to   = fingerprint[-8..-1]

      system(WOTSAP, from, to, err: File::NULL, out: File::NULL)
    end
  end
end
