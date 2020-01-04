require "rails_helper"

RSpec.describe SuperAdminMailer, type: :mailer do
  describe 'send notification email' do
    let!(:admin) { create(:user, :super_admin, organization_id: nil)}
    let!(:organization) { create(:organization) }

    it 'deliver success' do
      SuperAdminMailer.new_organization(organization).deliver_now
      mail = ActionMailer::Base.deliveries.last
      expect(mail.to).to match_array(User.super_admins.pluck(:email))
    end


    it 'with correct subject' do
      SuperAdminMailer.new_organization(organization).deliver_now
      mail = ActionMailer::Base.deliveries.last
      expect(mail.subject).to eq('New organization created')
    end
  end

  it 'send email thouth background job' do
    expect{
      create(:organization)
    }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end
end
