require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe ProcessPdfWorker, type: :worker do
  let!(:presentation) { create(:presentation) }

  before(:each) do
    Sidekiq::Worker.clear_all
  end

  it 'changes job count' do
    expect do
      ProcessPdfWorker.perform_async(presentation.id, '20x20')
    end.to change(ProcessPdfWorker.jobs, :size).by(1)

    ProcessPdfWorker.drain
    expect(ProcessPdfWorker.jobs.size).to eq(0)

    expect(presentation.screenshots).not_to be_empty

    presentation.screenshots.each do |screenshot|
      expect(screenshot.file).not_to be_nil
    end
  end
end
