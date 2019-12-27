require 'rails_helper'

RSpec.describe Account::NotificationsController, type: :controller do
  let!(:user) { create(:user, first_name: 'Bob') }
  let!(:notification) { create(:notification, notification_type: Notification::NOTIFICATION_TYPES.sample, notificable: user, user_id: user.id) }

  describe 'mark_all_as_read' do
    it 'marks all notifications as read' do
      sign_in user
      get :mark_all_as_read
      expect(user.notifications.find(notification.id).read).to eq(true)
    end
  end

end
