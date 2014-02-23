require 'spec_helper'

describe 'identities/show.html.haml' do
  before do
    assign :identity, FactoryGirl.build(:identity)
    render
  end

  subject { rendered }

  it { should have_content('Andrew Kvalheim') }
  it { should have_content('Andrew@Kvalhe.im') }
  it { should have_content('http://Andrew.Kvalhe.im/') }
  it { should have_content('B80C4E1E6F5544B277518173535B253E3B5AB9C6') }
end
