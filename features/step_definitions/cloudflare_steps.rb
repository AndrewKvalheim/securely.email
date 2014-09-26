When 'CloudFlare is failing' do
  stub_request(:post, 'https://www.cloudflare.com/api_json.html').to_return(
    status: 200,
    body: '{"result": "error", "msg": "Mock failure"}'
  )
end
