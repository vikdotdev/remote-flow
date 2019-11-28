class SuperAdminMailer < ApplicationMailer
  admins_email = User.where(role: User::SUPER_ADMIN).pluck(:email)
  default to: -> { admins_email },
          from: 'remote-floar@mail.com'
  def notify_email(organization)       
    @organization = organization
    mail(subject: "Created new organization")
  end
end
