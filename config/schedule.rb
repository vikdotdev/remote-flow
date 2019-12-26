set :output, "#{path}/log/cron.log"
set :whenever_command, "bundle exec whenever"
set :environment, ENV['RAILS_ENV']

every :monday, at: '8:00am' do
  runner 'SuperAdminMailer.send_statistic_about_new_users_and_organizations.deliver_now'
end
