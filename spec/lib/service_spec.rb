require 'spec_helper'
require 'service'

describe Service do
  describe 'class including Service' do
    subject { Class.new.include(Service) }

    it { should respond_to :call }
  end
end
