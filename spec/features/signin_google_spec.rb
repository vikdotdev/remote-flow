require 'rails_helper'

RSpec.feature 'Sign In user with Google', type: :feature do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, email: 'jesse@mountainmantechnologies.com', organization: organization) }
  context 'Sign In via Google' do
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

    scenario 'login user with google account' do
      visit root_path
      click_link 'Sign In'
      click_link 'Login with Google'

      expect(page).to have_content(:all, "Successfully authenticated from Google account.")
      expect(page).to have_current_path(root_path)
    end
  end
end
