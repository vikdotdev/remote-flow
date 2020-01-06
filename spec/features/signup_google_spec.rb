require 'rails_helper'

RSpec.feature 'Register new user', type: :feature do

  context 'Sign Up via Google' do
    background do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
        info: {
          email: 'jesse@mountainmantechnologies.com',
          first_name: 'Jesse',
          last_name: 'Spevack'
        },
        credentials: {
          token: 'abcdefg12345',
          refresh_token: '12345abcdefg',
          expires_at: DateTime.now,
        }
      })
    end

    scenario 'with partial user details heads to a pre-populated registration form' do
      visit root_path
      click_link 'Sign Up'
      click_link 'Create with Google'
      expect(page).to have_selector("input[value='Jesse']")
      expect(page).to have_selector("input[value='Spevack']")
      fill_in 'Organization Name', with: 'Example Organization'
      click_button('Create User')

      expect(page).to have_content(:all, "Welcome! You have signed up successfully.")
      expect(page).to have_current_path(root_path)
    end
  end
end
