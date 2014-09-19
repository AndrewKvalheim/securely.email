require 'key'

# Identity of a person, corresponding to one OpenGPG key
class Identity < ActiveRecord::Base
  validates :slug,        format:     { with: /\A[-.\w]+\z/ },
                          length:     { maximum: 64 },
                          presence:   true,
                          uniqueness: true
  validates :fingerprint, format:     { with: /\A[A-F\d]+\z/ },
                          length:     { is: 40 },
                          presence:   true,
                          uniqueness: true
  validate :key_existence

  attr_readonly :slug

  def key
    Rails.cache.fetch("/key/#{ fingerprint }", expires_in: 1.day) do
      Key.new(fingerprint)
    end
  end

  private

  def key_existence
    error = if errors.blank?
              'must exist on the key server' unless key.exists?
            else
              'was not checked against the key server'
            end

    errors.add(:fingerprint, error) if error
  end
end
