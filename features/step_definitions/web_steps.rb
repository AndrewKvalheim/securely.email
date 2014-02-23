When 'I go to the home page' do
  visit root_path
end

When %r{^I go to '(.+)'$} do |path|
  visit path
end

Then 'I should see something' do
  page.should have_content
end

Then %r{^I should see '([^']*)'$} do |content|
  page.should have_content(content)
end
