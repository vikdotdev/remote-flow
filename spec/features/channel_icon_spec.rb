require 'rails_helper'

RSpec.feature 'Channel icons visible on device layout', type: :feature do
  let!(:organization) { create(:organization) }
  let!(:device) { create(:device, organization: organization) }
  let!(:admin) { create(:admin, organization: organization) }
  let!(:channel_name) { '2nd Floor' }

  it 'creates channel with icon, then checks device layout' do
    visit '/'
    click_link 'Sign In'
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: 'passwd'
    click_button 'Login'
    visit '/account/channels'

    click_link 'Add New Channel'
    fill_in 'Name', with: channel_name

    icon_select = page.find('.js-select2-channel-icon')
    icon_select.find(
      "option[value='#{ActionController::Base.helpers.asset_path('channel_icons/camera')}']"
    ).select_option
    click_button 'Create Channel'

    visit device_path(device.token)

    expect(page).to have_content(channel_name)
    expect(page).to have_css(
      "img[src='#{ActionController::Base.helpers.asset_path('channel_icons/camera.svg')}']"
    )
  end
end
