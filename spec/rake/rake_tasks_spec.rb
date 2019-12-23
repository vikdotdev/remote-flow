require 'rails_helper'
Rails.application.load_tasks

RSpec.describe TestRakeTasks do
  describe "notify.rake" do
    it "updates a notifications" do
      nofitication = Notification.last
      Rake::Task["notify"].invoke
      expect(notification).to have_updated
    end
  end
end