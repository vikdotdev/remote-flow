require 'rails_helper'

RSpec.describe Channel, type: :model do
  let!(:organization) { create(:organization) }
  let!(:channel) { create(:channel, organization: organization) }
  let!(:admin) { create(:user, :admin, organization: organization) }

  describe 'factory spec' do
    it 'has factory' do
      expect(channel).to be_persisted
    end
  end

  describe 'callback spec' do
    it "triggers notify_deleted on destroy" do
      expect(channel).to receive(:notify_deleted)
      channel.destroy
    end
  end

  describe 'methods spec' do
    it '#notify_deleted should work as expected' do
      expect { channel.destroy }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  describe 'search spec' do
    it 'should update ES when the object is created' do
      Channel.__elasticsearch__.refresh_index!
      expect(Channel.search("#{channel.name}").records.length).to eq(1)
    end

    it 'should update ES when the object is destroyed' do
      channel.destroy!
      Channel.__elasticsearch__.refresh_index!
      expect(Channel.search("#{channel.name}").records.length).to eq(0)
    end
  end
end
