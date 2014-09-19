RSpec::Matchers.define :be_cacheable do
  match do
    response.cache_control[:public]
  end
end

RSpec::Matchers.define :be_private do
  match do
    response.cache_control[:private]
  end
end
