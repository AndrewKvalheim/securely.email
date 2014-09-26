require 'spec_helper'

describe Identity do
  describe 'backend' do
    it { should have_db_column(:slug) }
    it { should have_db_column(:fingerprint) }
    it { should have_db_index(:slug) }
  end

  describe 'creation' do
    it { should validate_presence_of(:slug) }
    it { should validate_uniqueness_of(:slug) }
    it { should ensure_length_of(:slug).is_at_most(64) }
    it { should allow_value(*%w(a A a.a a-a a_a a1 1)).for(:slug) }
    ['', ' ', ' a', "a\n", 'a/a', '~a', 'æ'].each do |slug|
      it { should_not allow_value(slug).for(:slug) }
    end
    it { should have_readonly_attribute(:slug) }
    it { should validate_presence_of(:fingerprint) }
    it { should validate_uniqueness_of(:fingerprint) }
    it { should ensure_length_of(:fingerprint).is_equal_to(40) }

    context 'with a typical key' do
      subject { FactoryGirl.build(:identity) }

      it { should be_valid }
      its(:'key.name')        { should eq('Example') }
      its(:'key.comment')     { should eq('Example') }
      its(:'key.email')       { should eq('example@example.com') }
      its(:'key.fingerprint') do
        should eq('81A46DCA7018FABFC72BB787253A0338239BC6E9')
      end
    end

    context 'with a key that has an ID collision' do
      subject { FactoryGirl.build(:colliding_identity) }

      it { should be_valid }
      its(:'key.name')        { should eq('Asheesh Laroia') }
      its(:'key.comment')     { should be_empty }
      its(:'key.email')       { should eq('ubuntu@asheesh.org') }
      its(:'key.fingerprint') do
        should eq('D00436A90C4BD12002020A3C37E1C17570096AD1')
      end
    end

    context 'with a nonexistent key' do
      subject { FactoryGirl.build(:nonexistent_identity) }

      it { should_not be_valid }
    end
  end
end
