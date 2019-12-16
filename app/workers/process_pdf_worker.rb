class ProcessPdfWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    puts 'WORKER RUNNING'
  end
end
