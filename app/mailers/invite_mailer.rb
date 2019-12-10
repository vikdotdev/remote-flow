class InviteMailer < ApplicationMailer
  def new_user_invite(invite)
    @invite = invite
    mail(to: invite.email, subject: "Invitation to #{@invite.organization.name}")
  end
end
