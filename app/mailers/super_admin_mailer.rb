class SuperAdminMailer < ApplicationMailer
  default from: 'remote-flow@mail.com'

  def new_organization_email(organization)
    @organization = organization
    mail(to: super_admin_emails, subject: 'New organization created')
  end

  def send_statistic_about_new_users_and_organizations
    @users_count = User.where(["? - created_at <= 7", Date.today]).count
    @organizatinos_count = Organization.where(["? - created_at <= 7", Date.today]).count
    mail(to: super_admin_emails, subject: 'Weekly statistics')
  end

  private

  def super_admin_emails
    User.super_admins.pluck(:email)
  end
end
