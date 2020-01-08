require 'rails_helper'

RSpec.describe Channel, type: :model do
  let!(:organization) { create(:organization) }
  let!(:channel) { create(:channel, :with_contents, organization: organization) }
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

  it 'has contents' do
    expect(channel.contents.count).to eq(3)
  end
end
