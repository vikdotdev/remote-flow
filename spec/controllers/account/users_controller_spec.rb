require 'rails_helper'

RSpec.describe Account::UsersController, type: :controller do
  render_views

  let!(:user) { create(:user) }
  let!(:user_valid_params) { { first_name: "John" } }
  let!(:user_invalid_params) { { first_name: "" } }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'renders index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  context 'GET /account/users/:id' do
    it 'should show user page' do
      get :show, params: { id: user.id }
      expect(response).to be_successful
    end

    it 'must display edit page' do
      get :edit, params: { id: user.id }
      expect(response).to render_template(:edit)
    end

    context 'update the user' do
      it 'with valid attributes' do
        patch :update, params: { id: user.id, user: user_valid_params }
        user.reload
        expect(user.first_name).to eq(user_valid_params[:first_name])
      end

      it 'shouldnt update and redirects to edit' do
        patch :update, params: { id: user.id, user: user_invalid_params }
        user.reload
        expect(user.first_name).not_to eq(user_valid_params[:first_name])
        expect(response).to render_template(:edit)
      end
    end

    it 'should delete user' do
      expect{ (delete :destroy, params: { id: user.id }) }.to change{ User.count }.by(-1)
      expect(response).to redirect_to account_users_path
    end
  end

end
