Given 'a typical identity' do
  @identity = FactoryGirl.create(:identity)
end

When 'I go to its contact page' do
  step "I go to '/#{ @identity.slug }'"
end

Then 'I should see information from its key' do
  step "I should see '#{ @identity.key.comment }'"
  step "I should see '#{ @identity.key.email }'"
  step "I should see '#{ @identity.key.fingerprint }'"
  step "I should see '#{ @identity.key.name }'"
end
