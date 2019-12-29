require 'rails_helper'

RSpec.feature 'user signup' do

  def stub_omniauth
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

  scenario 'using google oauth2' do
    stub_omniauth
    visit root_path
    expect(page).to have_link('Sign Up')
    click_link 'Sign Up'
    expect(page).to have_link('Create with Google')
    click_link 'Create with Google'
    fill_in 'Organization Name', with: 'Example Organization'
    fill_in 'First Name', with: 'Jesse'
    fill_in 'Last Name', with: 'Spevack'
    click_button('Create User')
    expect(page).to have_current_path(root_path)

    click_link 'Account'
    expect(page).to have_current_path(account_path)
    expect(page).to have_content('Jesse Spevack')
    expect(page).to have_link('Logout')
  end
end
