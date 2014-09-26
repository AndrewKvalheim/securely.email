require 'cloudflare'
require 'service'
require 'status'

# Invalidate a CloudFlare resource
class Invalidate
  include Service

  def call(path)
    invalidate(path)
  end

  private

  def cloudflare
    CloudFlare.connection(CLOUDFLARE_SECRET_KEY, CLOUDFLARE_EMAIL)
  end

  def invalidate(path)
    url = ROOT_URI.merge(path).to_s
    cloudflare.zone_file_purge(CLOUDFLARE_ZONE, url)

    Success.new
  rescue CloudFlare::RequestError => exception
    Failure.new message: exception.message
  rescue Timeout::Error, JSON::ParserError, TypeError
    Failure.new message: 'Failed to contact CloudFlare.'
  end
end
