class SuperAdminMailer < ApplicationMailer
  default from: 'remote-flow@mail.com'

  def new_organization_email(organization)
    @organization = organization
    mail(to: super_admin_emails, subject: 'New organization created')
  end

  def send_statistic_about_new_users_and_organizations
    @users_count = User.where(["DATE(created_at) >= ?", Date.today - 7.days]).count
    @organizatinos_count = Organization.where(["DATE(created_at) >= ?", Date.today - 7.days]).count
    mail(to: super_admin_emails, subject: 'Weekly statistics')
  end

  private

  def super_admin_emails
    User.super_admins.pluck(:email)
  end
end
