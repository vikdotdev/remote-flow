require 'rails_helper'

RSpec.describe Page, type: :model do
  describe 'factory spec' do
    let!(:page) { create(:content, :page) }

    it 'Page model has factories' do
      expect(page).to be_persisted
    end

    it 'Page model has title validation' do
      page.title = ' '
      expect(page).not_to be_valid
    end
  end
end
