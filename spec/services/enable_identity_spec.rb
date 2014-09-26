require 'spec_helper'
require 'status'

describe EnableIdentity do
  let(:identity) { FactoryGirl.build(:identity) }
  before { allow(Invalidate).to receive(:call).and_return(Success.new) }

  it 'accepts a trusted key and typical slug' do
    status = EnableIdentity.call(identity.slug, identity.fingerprint)

    expect(status.success?).to be_truthy
  end

  it 'rejects object pronouns' do
    %w(her him it me them us you).each do |slug|
      status = EnableIdentity.call(slug, identity.fingerprint)

      expect(status.success?).to be_falsey
    end
  end

  it 'rejects untrusted keys' do
    allow(Trust).to receive(:call).and_return(Failure.new)
    status = EnableIdentity.call(identity.slug, identity.fingerprint)

    expect(status.success?).to be_falsey
  end
end
