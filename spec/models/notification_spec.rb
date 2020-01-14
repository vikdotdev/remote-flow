require 'rails_helper'

RSpec.describe Notification, type: :model do
  let!(:some_notification) { create(:notification) }
  let!(:super_admin) { create(:user, :super_admin)}
  let!(:organization) { create(:organization) }
  let!(:admin) { create(:user, :admin, organization: organization) }
  let!(:manager) { create(:user, :manager, organization: organization) }

  describe 'factory specs' do
    it 'has factory' do
      expect(some_notification).to be_persisted
    end
  end

  describe 'notification has body' do
    it 'notification about new user has body' do
      expect(admin.notifications.where(
        notificable: manager,
        notification_type: Notification::USER_ADDED).first.body).to include(manager.full_name)
    end

    it 'notification about new organization has body' do
      expect(super_admin.notifications.where(
        notificable: organization,
        notification_type: Notification::ORGANIZATION_CREATED).first.body).to include(organization.name)
    end

    # it 'notification about deleted user has body' do
    #   manager.destroy
    #   expect(admin.notifications.where(
    #     notificable: manager,
    #     notification_type: Notification::USER_DELETED
    #     ).first.body
    #   ).to be_any
    # end
  end

  describe 'admin receives notifications abount user' do
    it 'admin has notification about new user' do
      expect(admin.notifications.where(
        notificable: manager,
        notification_type: Notification::USER_ADDED).first).to be_persisted
    end

    it 'admin has notification about deleted user' do
      expect{ manager.destroy }.to change(admin.notifications.where(
        notification_type: Notification::USER_DELETED),
        :count).by(1)
    end
  end

  describe 'super_admin receives notifications abount organization' do
    it 'super_admin has notification about new organization' do
      expect(super_admin.notifications.where(
        notificable: organization,
        notification_type: Notification::ORGANIZATION_CREATED)).to be_any
    end

    it 'super_admin has notification about deleted user' do
      expect{ organization.destroy }.to change(super_admin.notifications.where(
        notification_type: Notification::ORGANIZATION_DELETED),
        :count).by(1)
    end
  end
end
