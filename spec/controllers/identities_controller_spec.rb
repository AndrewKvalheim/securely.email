require 'spec_helper'

describe IdentitiesController do
  before do
    FactoryGirl.create(:identity)
  end

  describe 'Routing' do
    it { should route(:get, '/AndrewKvalheim').to('identities#show', slug: 'AndrewKvalheim') }
  end

  describe 'GET show' do
    before { get 'show', slug: 'AndrewKvalheim' }

    it { should respond_with(:success) }
    it { should render_with_layout('application') }
    it { should render_template('show') }
  end
end
