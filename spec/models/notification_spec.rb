require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:super_admin) { create(:user, :super_admin)}
  let(:organization) { create(:organization) }
  let(:admin) { create(:user, :admin, organization_id: organization.id) }
  let(:manager) { create(:user, :manager, organization_id: organization.id) }
  let(:notification) { create(:notification, :user_added, notificable: manager, user: admin) }

  describe 'factory specs' do
    it 'has factory' do
      expect(build(:notification)).to be_valid
    end
  end

  describe 'receiving notifications abount users' do
    it 'admin has notification about new user' do
      debugger
      expect(admin.notifications.first.notificable.id).to eq(manager.id)
      expect(admin.notifications.first.notificable.type).to eq(Notification::USER_ADDED)
    end

    it 'admin has notification about deleted user' do
      expect(admin.notifications.first.notificable.id).to eq(manager.id)
      expect(admin.notifications.first.notificable.type).to eq(Notification::USER_DELETED)
    end
  end

  describe 'receiving notifications abount organizations' do
    it 'super_admin has notification about new organization' do
      expect(super_admin.notifications.first.notificable.id).to eq(organization.id)
      expect(super_admin.notifications.first.notificable.type).to eq(Notification::ORGANIZATION_ADDED)
    end

    it 'super_admin has notification about deleted user' do
      expect(super_admin.notifications.first.notificable.id).to eq(organization.id)
      expect(super_admin.notifications.first.notificable.type).to eq(Notification::ORGANIZATION_DELETED)
    end
  end
end
