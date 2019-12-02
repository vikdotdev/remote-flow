require 'rails_helper'

RSpec.feature "Public page", type: :feature do
  describe 'test rendering', type: :feature do

    it 'visits pricing page' do
      visit '/'
      click_link "Pricing"
      page.assert_selector('a.btn', count: 9)
    end

    it 'visits root page' do
      visit '/'
      page.assert_selector('div.col-12', count: 13)
    end
  end
end
