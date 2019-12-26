class SuperAdminMailerPreview < ActionMailer::Preview
  def sample_preview
    SuperAdminMailer.send_statistic_about_new_users_and_organizations
  end
end
