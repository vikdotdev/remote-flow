class SuperAdminMailer < ApplicationMailer
  default from: 'remote-flow@mail.com'
  @super_admins_email = User.super_admins.pluck(:email)
  before_each :check_presentce_of_super_admin

  def new_organization_email(organization)
    @organization = organization
    mail(to: @super_admins_email, subject: 'New organization created')
  end

  def send_statistic_about_new_users_and_organizations
    @users_count = User.all(:conditions => ["? - created_at <= 7", Date.today]).count
    @organizatinos_count = Organization.all(:conditions => ["? - created_at <= 7", Date.today]).count
    mail(to: @super_admins_email, subject: 'Weekly statistics')
  end

  def check_presentce_of_super_admin
    return if @super_admins_email.empty?
  end
end
