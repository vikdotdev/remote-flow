require 'rails_helper'
require 'rake'
Rails.application.load_tasks

describe 'send_mail namespace rake tasks' do
  describe 'send_mail:send_statistic_to_super_admin' do
    Rake::Task.task_defined?("send_mail:send_statistic_to_super_admin")
  end
end
