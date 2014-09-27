require 'cucumber/rspec/doubles'
require 'status'

fingerprint = FactoryGirl.build(:identity).fingerprint

# Fake inclusion of the example key in the web of trust.
Before do
  allow(Trust).to receive(:call).and_call_original
  allow(Trust).to receive(:call).with(fingerprint).and_return(Success.new)
end
