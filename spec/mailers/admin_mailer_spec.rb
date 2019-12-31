require "rails_helper"

RSpec.describe AdminMailer, type: :mailer do
  let!(:admin) { create(:user, :admin, organization: organization) }
  let!(:manager) { create(:user, :manager, organization: organization) }
  let!(:organization) { create(:organization) }
  let!(:channel) { create(:channel, organization: organization) }

  describe 'send notification email' do
    context 'on channel delete' do
      it 'email is sent to the admins' do
        AdminMailer.delete_channel(channel).deliver_now
        mail = ActionMailer::Base.deliveries.last
        expect(mail.to).to match_array(organization.users.admins.pluck(:email))
      end

      it 'email is not sent to the managers' do
        AdminMailer.delete_channel(channel).deliver_now
        mail = ActionMailer::Base.deliveries.last
        expect(mail.to[0]).to_not eq manager.email
      end

      it 'with correct subject' do
        AdminMailer.delete_channel(channel).deliver_now
        mail = ActionMailer::Base.deliveries.last
        expect(mail.subject).to eq('Channel was deleted')
      end
    end
  end
end
