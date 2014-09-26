When 'I send no command' do
  identity = FactoryGirl.build(:identity)

  step "I send the command '' to '#{ identity.slug }'"
end

When 'I send a command with no signature' do
  identity = FactoryGirl.build(:identity)

  post "/#{ identity.slug }", command: 'enable'
end

When 'I send a command with an invalid signature' do
  identity = FactoryGirl.build(:identity)
  command = clearsign('enable').sub('enable', 'disable')

  post "/#{ identity.slug }", command: command
end

When %r{^I send the command '([^']*)'$} do |command|
  identity = FactoryGirl.build(:identity)

  step "I send the command '#{ command }' to '#{ identity.slug }'"
end

When %r{^I send the command '([^']*)' to '([^'/]*)'$} do |command, slug|
  post "/#{ slug }", command: clearsign(command)
end

Given %r{^the alias '([^']*)' is enabled$} do |slug|
  FactoryGirl.create(:identity, slug: slug)
end

Given %r{^the alias '([^']*)' is enabled by someone else$} do |slug|
  FactoryGirl.create(:other_identity, slug: slug)
end

Then %r{^I should receive '([^']*)'$} do |content|
  last_response.body.should have_content(content)
end
