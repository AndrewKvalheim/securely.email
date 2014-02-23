require 'spec_helper'

describe MetaController do
  describe 'Routing' do
    it { should route(:get, '/').to('meta#index') }
  end

  describe 'GET index' do
    before { get 'index' }

    it { should respond_with(:success) }
    it { should render_with_layout('application') }
    it { should render_template('index') }
  end
end
