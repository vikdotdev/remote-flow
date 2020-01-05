require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe ParsePdfWorker, type: :worker do
  let!(:presentation) { create(:presentation) }

  before(:each) do
    Sidekiq::Worker.clear_all
    Sidekiq::Testing.fake!
  end

  it 'changes job count' do
    expect do
      ParsePdfWorker.perform_async(presentation.id)
    end

    Sidekiq::Testing.inline! do
      expect(presentation.reload.presentation_body_plain).to_not be_nil
    end
  end
end
