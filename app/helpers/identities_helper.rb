require 'shellwords'

module IdentitiesHelper
  REFERENCE = 'B80C4E1E6F5544B277518173535B253E3B5AB9C6'
  WOTSAP = Shellwords.escape(Rails.root.join('wotsap').to_s)

  def connected_to?(fingerprint)
    Rails.cache.fetch("/wot/#{ fingerprint }", expires_in: 1.day) do
      from = Shellwords.escape(REFERENCE[-8..-1])
      to   = Shellwords.escape(fingerprint[-8..-1])

      system("#{ WOTSAP } #{ from } #{ to }", err: File::NULL, out: File::NULL)
    end
  end
end
