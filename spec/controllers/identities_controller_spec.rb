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

  describe 'web of trust detection' do
    let(:controller)  { IdentitiesController.new }
    let(:collision)   { 'D00436A90C4BD12002020A3C37E1C17570096AD1' }
    let(:connected)   { 'BE2B972FE80E101AAF828BB5F4D89A1810B196EF' }
    let(:nonexistent) { 'A4E2B0C325633D2120BEC0C6CD9E545436171BC6' }
    let(:reference)   { 'B80C4E1E6F5544B277518173535B253E3B5AB9C6' }

    it 'detects connection to a connected key' do
      expect(controller.send(:'connected_to?', connected)).to be_true
    end

    it 'detects connection to a key that has a collision' do
      expect(controller.send(:'connected_to?', collision)).to be_true
    end

    it 'detects connection to itself' do
      expect(controller.send(:'connected_to?', reference)).to be_true
    end

    it 'does not detect connection to a nonexistent key' do
      expect(controller.send(:'connected_to?', nonexistent)).to be_false
    end
  end
end
