class SuperAdminMailer < ApplicationMailer
  default from: 'remote-flow@mail.com'

  def new_organization_email(organization)
    admins_email = User.super_admins.pluck(:email)
    return false if admins_email.empty?

    @organization = organization
    mail(to: admins_email, subject: 'New organization created')
  end
end
