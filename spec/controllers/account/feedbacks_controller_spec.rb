require 'rails_helper'

RSpec.describe Account::FeedbacksController, type: :controller do
  let!(:user) { create(:user) }
  let!(:super_admin) { create(:user, :super_admin) }

  context 'when not logged in' do
    describe 'GET #index' do
      it 'redirect to login page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'when logged in as user' do
    before do
      sign_in user
    end

    describe 'GET #index' do
      it 'redirect to account page' do
        get :index
        expect(response).to redirect_to(account_path)
      end
    end
  end

  context 'when logged in as super_admin' do
    before do
      sign_in super_admin
    end

    describe 'GET #index' do
      it 'renders index template' do
        get :index
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end
    end
  end
end
