require 'rails_helper'

RSpec.describe Notification, type: :model do
  let!(:super_admin) { create(:user, :super_admin)}
  let!(:organization) { create(:organization) }
  let!(:admin) { create(:user, :admin, organization_id: organization.id) }
  let!(:manager) { create(:user, :manager, organization_id: organization.id) }
  # let!(:notification) { create(:notification, :user_added, notificable: manager, user: admin) }

  describe 'factory specs' do
    it 'has factory' do
      expect(create(:notification)).to be_persisted
    end
  end

  describe 'receiving notifications abount users' do
    it 'admin has notification about new user' do
      expect(admin.notifications.first.notificable.id).to eq(manager.id)
      expect(admin.notifications.first.notification_type).to eq(Notification::USER_ADDED)
    end

    it 'admin has notification about deleted user' do
      manager_id = manager.id
      manager.destroy!
      expect { User.find(manager_id) }.to raise_exception(ActiveRecord::RecordNotFound)
      expect(admin.notifications.second.notification_type).to eq(Notification::USER_DELETED)
    end
  end

  describe 'receiving notifications abount organizations' do
    it 'super_admin has notification about new organization' do
      expect(super_admin.notifications.first.notificable.id).to eq(organization.id)
      expect(super_admin.notifications.first.notification_type).to eq(Notification::ORGANIZATION_CREATED)
    end

    it 'super_admin has notification about deleted user' do
      organization_id = organization.id
      organization.destroy!
      expect { Organization.find(organization_id) }.to raise_exception(ActiveRecord::RecordNotFound)
      expect(super_admin.notifications.second.notification_type).to eq(Notification::ORGANIZATION_DELETED)
    end
  end
end
