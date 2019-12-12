require 'rails_helper'

RSpec.feature 'Impersonation', type: :feature do
  let!(:super_admin) { create(:super_admin) }
  let!(:admin) { create(:user, :admin) }

  it 'impersonates another user' do
    visit '/'
    click_link 'Sign In'
    fill_in 'Email', with: super_admin.email
    fill_in 'Password', with: 'passwd'
    click_button 'Login'
    visit "/account/users/#{admin.id}"
    click_link 'Impersonate'
    expect(page).to have_content 'Stop Impersonating'
    visit "/account/users/#{admin.id}"
    expect(page).not_to have_content 'Impersonate'
    click_link 'Stop Impersonating'
    expect(page).to have_current_path(account_path)
    visit "/account/users/#{admin.id}"
    expect(page).to have_content 'Impersonate'
  end
end
