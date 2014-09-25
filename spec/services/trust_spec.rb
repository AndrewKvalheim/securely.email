require 'spec_helper'

describe Trust do
  describe 'web of trust detection' do
    let(:collision)   { 'D00436A90C4BD12002020A3C37E1C17570096AD1' }
    let(:connected)   { 'BE2B972FE80E101AAF828BB5F4D89A1810B196EF' }
    let(:nonexistent) { 'A4E2B0C325633D2120BEC0C6CD9E545436171BC6' }
    let(:reference)   { 'B80C4E1E6F5544B277518173535B253E3B5AB9C6' }

    it 'detects connection to a connected key' do
      its(:connected_to?, connected) { should be_truthy }
    end

    it 'detects connection to a key that has a collision' do
      its(:connected_to?, collision) { should be_truthy }
    end

    it 'detects connection to itself' do
      its(:connected_to?, reference) { should be_truthy }
    end

    it 'does not detect connection to a nonexistent key' do
      its(:connected_to?, nonexistent) { should be_falsey }
    end
  end
end
