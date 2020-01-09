require 'rails_helper'

RSpec.feature 'Content Timeline', type: :feature do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, email: 'jesse@mountainmantechnologies.com', organization: organization) }
  let!(:content) { create(:gallery, organization: organization, title: 'Albuquerque') }


  it 'add record to content timeline' do
    visit '/'
    click_link "Sign In"
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'passwd'
    click_button 'Login'
    click_link 'My Account'
    expect(page).not_to have_content('Lubomir was here')
    click_link 'Content'
    expect(page).to have_content('Albuquerque')
    click_link 'Albuquerque'
    click_link 'Edit'
    fill_in 'Title', with: 'Lubomir was here'
    click_button 'Update Content'
    click_link 'Dashboard'
    expect(page).to have_content(:all, 'Lubomir was here')
  end
end
