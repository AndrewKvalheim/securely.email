require 'shellwords'

When 'I send no command' do
  step "I send the command '' to 'TestAlias'"
end

When 'I send a command with no signature' do
  post '/TestAlias', command: 'enable'
end

When 'I send a command with an invalid signature' do
  message = `echo enable | gpg --batch -o - --clearsign -`
  post '/TestAlias', command: message.sub('enable', 'disable')
end

When %r{^I send the command '([^']*)'$} do |command|
  step "I send the command '#{ command }' to 'TestAlias'"
end

When %r{^I send the command '([^']*)' to '([^'/]*)'$} do |command, slug|
  message = `echo #{ Shellwords.escape(command) } |
             gpg --batch -o - --clearsign -`
  post "/#{ slug }", command: message
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
