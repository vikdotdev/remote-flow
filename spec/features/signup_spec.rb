require 'rails_helper'

RSpec.feature 'Sign Up', type: :feature do
  it 'signs user up' do
    visit '/'
    click_link 'Sign Up'
    fill_in 'Organization Name', with: 'Example Organization'
    fill_in 'Email', with: 'example@email.com'
    fill_in 'First Name', with: 'Mike'
    fill_in 'Last Name', with: 'Miller'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Create User'
    expect(page).to have_current_path(root_path)

    click_link 'Account'
    expect(page).to have_current_path(account_path)
    expect(page).to have_content('Mike Miller')
  end
end
