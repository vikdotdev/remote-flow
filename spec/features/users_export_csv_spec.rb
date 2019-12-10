
require 'rails_helper'

RSpec.feature "Users export", type: :feature do
  describe 'to csv', type: :feature do
    let!(:user) { create(:user) }

    it 'file downloud' do
      visit '/'
      click_link "Sign In"
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'passwd'
      click_button 'Login'
      visit'account/users'
      click_link 'Export to CSV'
      expect( page.response_headers['Content-Disposition']).to include "filename=\"users-#{Date.today}.csv\""
    end
  end
end