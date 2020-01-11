require 'rails_helper'

RSpec.feature 'Multiple contents select', type: :feature do
  let!(:organization) { create(:organization) }
  let!(:video) { create(:video, organization: organization) }
  let!(:gallery) { create(:gallery, organization: organization) }
  let!(:admin) { create(:admin, organization: organization) }

  CHANNEL_NAME = 'select multiple example channel'
  it 'creates channel with multiple contents, then updates it' do
    visit '/'
    click_link 'Sign In'
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: 'passwd'
    click_button 'Login'
    visit '/account/channels'

    click_link 'Add New Channel'
    fill_in 'Name', with: CHANNEL_NAME
    select = page.find('.js-select2-contents')
    select.find("option[value='#{video.id}']").select_option
    select.find("option[value='#{gallery.id}']").select_option
    click_button 'Create Channel'
    visit '/account/channels'
    click_link CHANNEL_NAME
    expect(page).to have_content(video.title)
    expect(page).to have_content(gallery.title)

    click_link 'Edit'
    select = page.find('.js-select2-contents')
    select.find("option[value='#{gallery.id}']").unselect_option
    click_button 'Update Channel'
    expect(page).to have_content(video.title)
    expect(page).not_to have_content(gallery.title)
  end
end
