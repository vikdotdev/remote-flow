require 'rails_helper'

RSpec.feature "Users", type: :feature do
  describe 'when user has role admin', type: :feature do
    let!(:admin) { create(:user, :super_admin) }
    let!(:user) { create(:user, role: "manager") }

    it 'change password other user' do
      visit '/'
      click_link "Sign In"
      fill_in 'Email', with: admin.email
      fill_in 'Password', with: 'passwd'
      click_button 'Login'
      visit 'account/users'
      click_link user.full_name
      click_link 'Edit'
      fill_in 'user[password]', with: '123456'
      fill_in 'user[password_confirmation]', with: '123456'
      click_button 'Change password'
      expect(page).to have_current_path(account_user_path(user))
    end
  end
end

