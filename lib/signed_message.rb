# GPG-signed message
class SignedMessage
  attr_reader :body, :fingerprint

  def initialize(data)
    @body, @fingerprint, @valid = unpack(data)
  end

  def valid? # rubocop:disable Style/TrivialAccessors
    @valid
  end

  private

  def receive(fingerprint)
    system(GPG_ENV, 'gpg', '--recv-keys', fingerprint)
  end

  def unpack(data, auto_receive = true)
    message = GPGME::Data.new

    begin
      GPGME::Crypto.verify(data, output: message) do |signature|
        parts = if auto_receive && signature.no_key?
                  receive signature.fingerprint

                  unpack(data, false)
                else
                  [message.to_s, signature.key.fingerprint, signature.valid?]
                end

        return parts
      end
    rescue GPGME::Error::NoData
      return [nil, nil, false]
    end
  end
end
