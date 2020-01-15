require 'rails_helper'

RSpec.describe Account::NotificationsController, type: :controller do
  let!(:organization) { create(:organization) }
  let!(:admin) { create(:user, :admin, organization: organization) }
  let!(:manager) { create(:user, :manager, organization: organization) }

  describe 'Marking notifications as read' do
    it 'marks all notifications as read' do
      sign_in admin
      get :mark_all_as_read
      expect(admin.notifications.where(notificable: manager)).to all( have_attributes(read: true))
    end
  end

end
