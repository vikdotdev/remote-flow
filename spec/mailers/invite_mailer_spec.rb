require 'rails_helper'

RSpec.describe InviteMailer, type: :mailer do
  let!(:user) { create(:user, :admin) }
  let!(:invite) { create(:invite, sender: user) }
  let(:mail) { invite.send_invite_email }

  it 'changes deliveries count' do
    expect { mail }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it 'has invitation link on mail' do
    expect(mail.body.encoded)
      .to include("#{new_accept_invite_url}?invite_token=#{invite.token}")
  end
end
