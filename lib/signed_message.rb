require 'shellwords'

class SignedMessage
  attr_reader :body, :fingerprint

  class MissingKey < StandardError; end

  def initialize(data)
    unpack(data)
  end

  def valid?
    @valid
  end

  private

  def unpack(data)
    output = GPGME::Data.new
    signature = nil

    begin
      GPGME::Crypto.verify(data, output: output) do |first_try|
        if first_try.no_key?
          system "gpg --recv-keys #{Shellwords.escape(first_try.fingerprint)}"

          GPGME::Crypto.verify(data, output: output) do |second_try|
            if second_try.no_key?
              raise MissingKey
            else
              signature = second_try
            end
          end
        else
          signature = first_try
        end
      end
    rescue GPGME::Error::NoData
    end

    if signature
      @body        = output.to_s
      @fingerprint = signature.key.fingerprint
      @valid       = signature.valid?
    end
  end
end
