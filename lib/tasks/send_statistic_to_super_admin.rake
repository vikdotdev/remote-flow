namespace :send_mail do
  desc 'Send super_admin statistic about new users and organizations'

  task send_statistic_to_super_admin: :environment do
    SuperAdminMailer.send_statistic_about_new_users_and_organizations.deliver_now
  end
end
