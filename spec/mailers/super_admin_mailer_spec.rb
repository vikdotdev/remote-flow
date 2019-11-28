require "rails_helper"

RSpec.describe SuperAdminMailer, type: :mailer do 
  describe 'send notify' do
    let(:admin) { create(:user, role:"super_admin")}
    let(:organization) { create(:organization) }     
    let(:mail) { organization.save }

    it 'renders the subject' do
      expect(mail.subject).to eq('Created new organization')      
    end

    it 'with name\'s new organization' do
      expect(mail.to).to match(admin.email)
    end
  end
end
