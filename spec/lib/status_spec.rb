require 'spec_helper'

describe Success do
  subject { Success.new }

  its(:success?) { should be_truthy }
end

describe Failure do
  subject { Failure.new }

  its(:success?) { should be_falsey }
end
