When 'I go to the home page' do
  visit root_path
end

Then 'I should see something' do
  page.should have_content
end
