
require 'rails_helper'

RSpec.feature "Users export", type: :feature do
  describe 'to csv', type: :feature do
    let!(:admin) { create(:user) }
    let!(:user) { create(:user, role: "manager") }


    it 'when user has role admin' do
      visit '/'
      click_link "Sign In"
      fill_in 'Email', with: admin.email
      fill_in 'Password', with: 'passwd'
      click_button 'Login'
      visit 'account/users'
      click_link 'Export to CSV'
      expect(page.response_headers['Content-Disposition']).to include "users-#{Date.today}.csv"
    end

    it 'when user has role manager' do
      visit '/'
      click_link "Sign In"
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'passwd'
      click_button 'Login'
      visit 'account/users'
      expect(page).to have_current_path(account_path)
    end
  end
end