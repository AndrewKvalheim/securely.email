require 'spec_helper'

describe Invalidate do
  it 'handles success' do
    stub_request(:post, 'https://www.cloudflare.com/api_json.html').to_return(
      status: 200,
      body: '{"result": "success", "msg": null}'
    )

    expect(Invalidate.call('foo').success?).to be_truthy
  end

  it 'handles soft failure' do
    stub_request(:post, 'https://www.cloudflare.com/api_json.html').to_return(
      status: 200,
      body: '{"result": "error", "msg": "Mock failure"}'
    )

    expect(Invalidate.call('bar').success?).to be_falsey
  end

  it 'handles hard failure with no response' do
    stub_request(:post, 'https://www.cloudflare.com/api_json.html').to_return(
      status: 500
    )

    expect(Invalidate.call('bar').success?).to be_falsey
  end

  it 'handles hard failure with a malformed response' do
    stub_request(:post, 'https://www.cloudflare.com/api_json.html').to_return(
      status: 500,
      body: 'This is not JSON.'
    )

    expect(Invalidate.call('bar').success?).to be_falsey
  end

  it 'handles timeouts' do
    stub_request(:post, 'https://www.cloudflare.com/api_json.html').to_timeout

    expect(Invalidate.call('bar').success?).to be_falsey
  end
end
