# Serializable wrapper for GPGME keys
class Key
  attr_reader :comment, :email, :fingerprint, :name

  def initialize(fingerprint)
    @fingerprint = fingerprint

    lookup(fingerprint).try(:tap) do |key|
      @comment = key.primary_uid.comment
      @email   = key.primary_uid.email
      @exists  = true
      @name    = key.primary_uid.name
    end
  end

  def exists? # rubocop:disable Style/TrivialAccessors
    @exists
  end

  private

  def lookup(fingerprint)
    GPGME::Ctx.new(keylist_mode: GPGME::KEYLIST_MODE_EXTERN) do |context|
      context.get_key("0x#{ fingerprint }")
    end
  rescue EOFError # No results found
    nil
  end
end
