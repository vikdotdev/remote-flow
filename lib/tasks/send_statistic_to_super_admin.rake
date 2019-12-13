namespace :send_statistic_to_super_admin do
  desc 'Send super_admin statistic about new users and organizations'
  task send_statistic_to_super_admin: :development do
    SuperAdminMailer.send_statistic_about_new_users_and_organizations
  end
end
