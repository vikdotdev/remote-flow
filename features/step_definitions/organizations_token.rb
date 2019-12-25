Given 'Auth like admin' do
  @admin = FactoryBot.create(:user, :admin)

  visit '/'
  click_link "Sign In"
  fill_in 'Email', with: @admin.email
  fill_in 'Password', with: 'passwd'
  click_button 'Login'
end

When 'I am on organization page' do
  visit '/account/my_organization'
end

Then 'I should see organization token' do
  page.should have_content(@admin.organization.token)
end
