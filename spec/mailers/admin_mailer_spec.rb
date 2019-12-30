require "rails_helper"

RSpec.describe AdminMailer, type: :mailer do
  describe 'send notification email' do
    let!(:admin) { create(:user, :admin, organization: organization) }
    let!(:organization) { create(:organization) }
    let!(:channel) { create(:channel, organization: organization) }
    let!(:mail) { AdminMailer.delete_channel_email(channel) }

    it 'deliver success' do
      expect { channel.destroy }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'with admins emails' do
      expect(mail.to).to match_array(organization.users.admins.pluck(:email))
    end

    it 'with correct subject' do
      expect(mail.subject).to eq('Channel was deleted')
    end
  end
end
