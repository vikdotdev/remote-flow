require "rails_helper"

RSpec.describe SuperAdminMailer, type: :mailer do
  describe 'send notification email' do
    let!(:admin) { create(:user, :super_admin, organization_id: nil)}
    let!(:organization) { create(:organization) }
    let!(:mail) { SuperAdminMailer.new_organization_email(organization)}

    it 'deliver success' do
      expect{create(:organization)}.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'with admins emails' do
      expect(mail.to).to match_array(User.super_admins.pluck(:email))
    end

    it 'with correct subject' do
      expect(mail.subject).to eq('New organization created')
    end
  end

  describe 'has'
end
