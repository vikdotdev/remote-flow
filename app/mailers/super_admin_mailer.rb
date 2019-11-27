class SuperAdminMailer < ApplicationMailer
  default from: 'remote-floar@mail.com'
  
  def notify_email(org)
    @org = org    
    mail(to: 'smtp://localhost:1025', subject: 'Welcome to My Awesome Site')
  end
end
