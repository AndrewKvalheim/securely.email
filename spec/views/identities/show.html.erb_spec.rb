require 'spec_helper'

describe 'identities/show.html.haml' do
  before do
    assign :identity, FactoryGirl.build(:identity)
    render
  end

  subject { rendered }

  it { should have_content('Example') }
  it { should have_content('Example') }
  it { should have_content('example@example.com') }
  it { should have_content('81A46DCA7018FABFC72BB787253A0338239BC6E9') }
end
