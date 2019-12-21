require 'rails_helper'

RSpec.feature "Users", type: :feature do
  describe 'when user has role admin', type: :feature do
    let!(:super_admin) { create(:user, :super_admin) }
    let!(:user) { create(:user, role: "manager") }

    it 'change password other user' do
      visit '/'
      click_link "Sign In"
      fill_in 'Email', with: super_admin.email
      fill_in 'Password', with: 'passwd'
      click_button 'Login'
      visit 'account/users'
      click_link user.full_name
      click_link 'Edit'
      fill_in 'user[password]', with: '123456'
      fill_in 'user[password_confirmation]', with: '123456'
      click_button 'Update User'
      first('#menu-logout').click_link 'Logout'
      click_link "Sign In"
      fill_in 'Email', with: user.email
      fill_in 'Password', with: '123456'
      click_button 'Login'
      expect(page).to have_current_path('/')
    end
  end
end

