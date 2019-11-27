require 'rails_helper'

RSpec.feature "Sign in", type: :feature do
  describe 'the signin proccess', type: :feature do
    let!(:user) { create(:user) }

    it 'sign in user' do 
      visit '/'
      click_link "Log in"
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'passwd'
      click_button 'Login'
      expect(page).to have_current_path(root_path)
    end
  end
end
