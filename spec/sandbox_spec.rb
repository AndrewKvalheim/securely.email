require 'spec_helper'

# Warning: Requests made by GPG are not sandboxed.

feature 'HTTP sandbox' do
  let(:external) { URI('https://andrew.kvalhe.im/robots.txt') }
  let(:blocked) { WebMock::NetConnectNotAllowedError }

  it 'blocks external HTTP requests' do
    expect { Net::HTTP.get(external) }.to raise_error(blocked)
  end
end
