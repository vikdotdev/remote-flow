require 'rails_helper'

RSpec.feature "Organization Logo", type: :feature do
  describe 'test logo is set to default if not present', type: :feature do
    let!(:organization) { create(:organization, logo: nil) }
    let!(:super_admin) { create(:user, :super_admin) }

    it 'visits organization page' do
      visit '/'
      click_link "Sign In"
      fill_in 'Email', with: super_admin.email
      fill_in 'Password', with: 'passwd'
      click_button 'Login'

      visit "/account/organizations/#{organization.id}"
      page.find('img.logo-img')['src'].should including "/assets/fallback/logo/default"
    end
  end
end