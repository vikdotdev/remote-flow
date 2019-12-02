require 'rails_helper'

RSpec.feature "Public page", type: :feature do
  describe 'test rendering', type: :feature do

    it 'visits pricing page' do
      visit '/'
      click_link "Pricing"
      page.find('h1.pricing-h', text: 'Plans and Pricing')
    end

    it 'visits root page' do
      visit '/'
      page.find('h2', text: 'Unique Features')
    end
  end
end
