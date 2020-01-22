require 'rails_helper'

RSpec.describe Account::SearchController, type: :controller do
  render_views

  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }

  context 'when not logged in' do
    describe 'GET #search' do
      it 'redirects to login page' do
        get :search
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'when logged in as user' do
    before do
      sign_in user
    end

    describe 'GET #index' do
      it 'renders index template' do
        get :search
        expect(response).to be_successful
        expect(response).to render_template(:search)
      end
    end
  end
end
