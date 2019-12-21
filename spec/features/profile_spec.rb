require 'rails_helper'

RSpec.feature "Profile", type: :feature do
  describe 'when user', type: :feature do
    let!(:super_admin) { create(:user, :super_admin) }

    it 'change password other user' do
      visit '/'
      click_link "Sign In"
      fill_in 'Email', with: super_admin.email
      fill_in 'Password', with: 'passwd'
      click_button 'Login'
      visit 'account/profile/edit'
      click_link 'Change Password'
      fill_in 'user[current_password]', with: 'passwd'
      fill_in 'user[password]', with: '123456'
      fill_in 'user[password_confirmation]', with: '123456'
      click_button 'Change password'
      first('#menu-logout').click_link 'Logout'
      click_link "Sign In"
      fill_in 'Email', with: super_admin.email
      fill_in 'Password', with: '123456'
      click_button 'Login'
      expect(page).to have_current_path('/')
    end
  end
end

