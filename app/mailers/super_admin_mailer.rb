class SuperAdminMailer < ApplicationMailer
  default from: 'remote-floar@mail.com'
  def new_organization_email(organization)
    admins_email = User.super_admins.pluck(:email)
    return false if admins_email.empty?
    @organization = organization
    mail(to: admins_email, subject: "Created new organization")
  end
end
