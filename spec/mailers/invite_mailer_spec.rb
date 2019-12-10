require 'rails_helper'

RSpec.describe InviteMailer, type: :mailer do
  let!(:user) { create(:user, :admin) }
  let!(:invite) { create(:invite, sender: user) }
  let(:mail) do
    invite.send_invite_email
  end

  it 'changes deliveries count' do
    expect { mail }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it 'has invitation link on mail' do
    expect(mail.body.encoded)
      .to include("http://localhost:3000/users/sign_up?invite_token=#{invite.token}")
  end
end
