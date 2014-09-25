require 'spec_helper'
require 'web_examples'

describe IdentitiesController do
  before do
    FactoryGirl.create(:identity)
  end

  describe 'Routing' do
    slug = 'Example'
    it { should route(:get, "/#{slug}").to('identities#show', slug: slug) }
  end

  describe 'GET show' do
    before { get 'show', slug: 'Example' }

    it { should respond_with(:success) }
    it { should be_cacheable }
    it { should render_with_layout('application') }
    it { should render_template('show') }
  end
end
