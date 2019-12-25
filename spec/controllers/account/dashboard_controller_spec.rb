require 'rails_helper'

RSpec.describe Account::DashboardController, type: :controller do
  render_views

  let(:user) { create(:user) }
  let!(:super_admin) { create(:user, :super_admin) }


  context 'when super_admin logged in' do
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

  context 'when logged in as non-super_admin' do
    before do
      sign_in user
    end

    describe 'action test' do
      it 'should show index page' do
        get :index
        expect(response).to be_successful
      end

      it 'should not show super_admin analytics page' do
        get :analytics
        expect(response).to redirect_to(account_path)
      end
    end
  end
end
