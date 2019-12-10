require 'rails_helper'

RSpec.describe InviteMailer, type: :mailer do
  let!(:user) { create(:user, :admin) }
  let!(:invite) { create(:invite, sender: user) }
  let!(:mail) do
    InviteMailer.new_user_invite(
      invite, new_user_registration_url(invite_token: invite.token)
    )
  end

  it 'changes deliveries count' do
    skip 'not working'
    expect { create(:invite) }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it 'has invitation link on mail' do
    skip 'TODO - implement'
    expect(mail.body.encoded)
      .to match("http://aplication_url/#{user.id}/confirmation")
  end
end
