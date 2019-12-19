require 'rails_helper'

RSpec.feature "Profile", type: :feature do
  describe 'when user', type: :feature do
    let!(:admin) { create(:user, :super_admin) }
    let!(:user) { create(:user, role: "manager") }

    it 'change password other user' do
      visit '/'
      click_link "Sign In"
      fill_in 'Email', with: admin.email
      fill_in 'Password', with: 'passwd'
      click_button 'Login'
      visit 'account/profile/edit'
      click_link 'Change Password'
      fill_in 'user[current_password]', with: 'passwd'
      fill_in 'user[password]', with: '123456'
      fill_in 'user[password_confirmation]', with: '123456'
      click_button 'Change password'
      expect(page).to have_current_path(edit_account_profile_path)
    end
  end
end

