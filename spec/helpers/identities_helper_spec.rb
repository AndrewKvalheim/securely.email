require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the IdentitiesHelper. For example:
#
# describe IdentitiesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe IdentitiesHelper do
  describe 'web of trust detection' do
    let(:collision)   { 'D00436A90C4BD12002020A3C37E1C17570096AD1' }
    let(:connected)   { 'BE2B972FE80E101AAF828BB5F4D89A1810B196EF' }
    let(:nonexistent) { 'A4E2B0C325633D2120BEC0C6CD9E545436171BC6' }
    let(:reference)   { 'B80C4E1E6F5544B277518173535B253E3B5AB9C6' }

    it 'detects connection to a connected key' do
      expect(connected_to?(connected)).to be_true
    end

    it 'detects connection to a key that has a collision' do
      expect(connected_to?(collision)).to be_true
    end

    it 'detects connection to itself' do
      expect(connected_to?(reference)).to be_true
    end

    it 'does not detect connection to a nonexistent key' do
      expect(connected_to?(nonexistent)).to be_false
    end
  end
end
