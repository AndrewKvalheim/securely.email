require 'webmock/cucumber'

Before do
  # CloudFlare invalidations
  stub_request(:post, 'https://www.cloudflare.com/api_json.html').to_return(
    status: 200,
    body: '{"result": "success", "msg": null}'
  )
end
