class SuperAdminMailer < ApplicationMailer
  default from: 'remote-floar@mail.com'
  def notify_email(organization)   
    admins_email = User.where(role: User::SUPER_ADMIN).pluck(:email)        
    return false if admins_email.empty?
    @organization = organization
    mail(to: admins_email, subject: "Created new organization")
  end
end
