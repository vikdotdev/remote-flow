require 'rails_helper'

RSpec.describe Organization, type: :model do
  let!(:organization) { create(:organization) }

  describe 'factory specs' do

    it 'has factory' do
      expect(organization).to be_persisted
    end
  end

  it 'sends slack notification on organization creation' do
    notifier = instance_double(Slack::Notifier)
    allow(Slack::Notifier).to receive(:new).and_return(notifier)
    expect(notifier).to receive(:ping)
    Organization.create(name: 'hey')
  end

  describe 'callback spec' do
    it "triggers #send_email_notification on create" do
      organization = build(:organization)
      expect(organization).to receive(:send_email_notification)
      organization.save
    end
  end
end
