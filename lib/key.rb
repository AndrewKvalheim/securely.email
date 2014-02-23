# Serializable wrapper for GPGME keys
class Key
  attr_reader :comment, :email, :fingerprint, :name

  def initialize(fingerprint)
    @fingerprint = fingerprint

    get_key.try(:tap) do |key|
      @comment = key.primary_uid.comment
      @email   = key.primary_uid.email
      @exists  = true
      @name    = key.primary_uid.name
    end
  end

  def exists?
    @exists
  end

  private

  def get_key
    # GPGME raises EOFError when no results are found.
    begin
      GPGME::Ctx.new(keylist_mode: GPGME::KEYLIST_MODE_EXTERN) do |context|
        context.get_key("0x#{ @fingerprint }")
      end
    rescue EOFError
      nil
    end
  end
end
