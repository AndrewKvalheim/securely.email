require 'status'

fingerprint = FactoryGirl.build(:identity).fingerprint

# Fake inclusion of the example key in the web of trust.
RSpec.configure do |config|
  config.before do
    allow(Trust).to receive(:call).and_call_original
    allow(Trust).to receive(:call).with(fingerprint).and_return(Success.new)
  end
end
