require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe ParsePdfWorker, type: :worker do
  let!(:presentation) { create(:presentation) }

  it 'changes job count' do
    Sidekiq::Testing.inline! do
      ParsePdfWorker.new.perform(presentation.id)
      expect(presentation.reload.presentation_body_plain).to include('pdf995')
    end
  end
end
