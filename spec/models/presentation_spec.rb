require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe Presentation, type: :model do
  describe 'factory spec' do
    let!(:presentation) { create(:presentation_with_screenshots) }

    it 'has factories' do
      expect(presentation).to be_persisted
    end

    it 'has screenshots and thumbnails' do
      Sidekiq::Testing.inline! do
        presentation = FactoryBot.create(:presentation)
        expect(presentation.screenshots.count).to eq(5)
        expect(presentation.screenshots.each { |s| s.file.thumb }.count).to eq(5)
      end
    end
  end
end
