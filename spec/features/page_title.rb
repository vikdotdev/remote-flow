require 'rails_helper'

RSpec.feature 'Page title', type: :feature do
  describe 'test page titles', type: :feature do
    let!(:organization) { create(:organization, name: 'Organization title') }
    let!(:user) { create(:user, organization: organization) }
    let!(:super_admin) { create(:user, :super_admin) }
    let!(:channel) { create(:channel, name: 'Channel title', organization: organization) }
    let!(:video) { create(:video, title: 'Video title', organization: organization) }
    let!(:device) { create(:device, :active, name: 'Device title', organization: organization) }


    it 'channel page title' do
      visit '/'
      click_link "Sign In"
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'passwd'
      click_button 'Login'

      visit "/account/channels/#{channel.id}"
      expect(page).to have_title('Remote Flow | Channel title')
    end

    it 'content page title' do
      visit '/'
      click_link "Sign In"
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'passwd'
      click_button 'Login'

      visit "/account/contents/#{video.id}"
      expect(page).to have_title('Remote Flow | Video title')
    end

    it 'device page title' do
      visit '/'
      click_link "Sign In"
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'passwd'
      click_button 'Login'

      visit "/account/devices/#{device.id}"
      expect(page).to have_title('Remote Flow | Device title')
    end

    it 'device page title' do
      visit '/'
      click_link "Sign In"
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'passwd'
      click_button 'Login'

      visit "/account/devices/#{device.id}"
      expect(page).to have_title('Remote Flow | Device title')
    end

    it 'organization page title' do
      visit '/'
      click_link "Sign In"
      fill_in 'Email', with: super_admin.email
      fill_in 'Password', with: 'passwd'
      click_button 'Login'

      visit "/account/organizations/#{organization.id}"
      expect(page).to have_title('Remote Flow | Organization title')
    end

    it 'user page title' do
      visit '/'
      click_link "Sign In"
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'passwd'
      click_button 'Login'

      visit "/account/users/#{user.id}"
      expect(page).to have_title("Remote Flow | #{user.full_name}")
    end

    it 'public page title' do
      visit '/'

      expect(page).to have_title('Remote Flow | Public page')
    end

    it 'pricing page title' do
      visit '/pricing'

      expect(page).to have_title('Remote Flow | Pricing')
    end

    it 'about us page title' do
      visit '/about_us'

      expect(page).to have_title('Remote Flow | About us')
    end

  end
end
