require 'rails_helper'

RSpec.describe ParsePdfWorker, type: :worker do
  let!(:presentation) { create(:presentation) }

  before(:each) do
    Sidekiq::Worker.clear_all
  end

  it 'changes job count' do
    expect do
      ParsePdfWorker.perform_async(presentation.id)
    end.to change(ParsePdfWorker.jobs, :size).by(1)

    ParsePdfWorker.drain
    expect(ParsePdfWorker.jobs.size).to eq(0)

    expect(presentation.presentation_body_plain).not_to be_nil
  end
end
