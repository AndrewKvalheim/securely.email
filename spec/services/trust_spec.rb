require 'spec_helper'

describe Trust do
  let(:connected)   { FactoryGirl.build(:identity).fingerprint }
  let(:collision)   { FactoryGirl.build(:colliding_identity).fingerprint }
  let(:nonexistent) { FactoryGirl.build(:nonexistent_identity).fingerprint }

  it 'trusts the reference key' do
    expect(Trust.call(REFERENCE).success?).to be_truthy
  end

  it 'trusts a connected key' do
    expect(Trust.call(connected).success?).to be_truthy
  end

  it 'trusts a connected key that has a collision' do
    expect(Trust.call(collision).success?).to be_truthy
  end


  it 'does not trust a nonexistent key' do
    expect(Trust.call(nonexistent).success?).to be_falsey
  end
end
