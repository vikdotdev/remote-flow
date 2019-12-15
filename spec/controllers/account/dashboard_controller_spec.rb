require 'rails_helper'

RSpec.describe Account::DashboardController, type: :controller do
  render_views

  let(:user) { create(:user) }
  let!(:super_admin) { create(:user, :super_admin) }

  before do
    sign_in super_admin
  end

  describe 'action test' do
    it 'should show index page' do
      get :index
      expect(response).to be_successful
    end

    it 'should show analytics page' do
      get :analytics
      expect(response).to be_successful
    end
  end
end
