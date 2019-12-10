class InviteMailer < ApplicationMailer
  def new_user_invite(invite, invite_path)
    @invite_path = invite_path
    @invite = invite
    mail(to: invite.email, subject: 'Account Invitation')
  end
end
