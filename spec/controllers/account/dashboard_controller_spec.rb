require 'rails_helper'

RSpec.describe Account::DashboardController, type: :controller do
  render_views

  let!(:organization) { create(:organization) }
  let(:current_user) { build(:user, organization: organization) }
  let(:user) { build(:user, organization: organization) }

  before(:each) do
    user.current_user = current_user
    user.save
  end

  before do
    sign_in user
  end

  describe 'action test' do
    it 'should show index page' do
      get :index
      expect(response).to be_successful
    end
  end
end
