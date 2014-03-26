RSpec::Matchers.define :be_cacheable do |expected|
  match do |actual|
    response.cache_control[:public]
  end
end

RSpec::Matchers.define :be_private do |expected|
  match do |actual|
    response.cache_control[:private]
  end
end
