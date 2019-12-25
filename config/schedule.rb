set :output, "#{path}/log/cron.log"


every :monday, at: '8:00am' do
  SuperAdminMailer.send_statistic_about_new_users_and_organizations.deliver_now
end