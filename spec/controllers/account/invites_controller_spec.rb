require 'rails_helper'

RSpec.describe Account::InvitesController, type: :controller do
  let!(:user) { create(:user, first_name: 'Bob') }
  let!(:super_admin) { create(:super_admin, first_name: 'Kelly') }

  context 'when not logged in' do
    describe 'GET #new' do
      it 'redirects to login page' do
        get :new
        expect(response).not_to render_template(:new)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'POST #create' do
      it 'redirects to login page' do
        post :create, params: {
          invite: {
            email: 'valid@mail.co',
            role: User::ADMIN
          }
        }
        expect(response).not_to redirect_to(account_users_path)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'when logged in as regular admin' do
    before do
      sign_in user
    end

    describe 'GET #new' do
      it 'renders new template' do
        get :new
        expect(response).to render_template(:new)
      end
    end

    describe 'POST #create' do
      it 'redirects to account_path' do
        post :create, params: {
          invite: {
            email: 'valid@mail.co',
            role: User::ADMIN
          }
        }
        expect(response).to redirect_to(account_invites_path)
      end

      it 'renders new when invalid email' do
        post :create, params: {
          invite: {
            email: 'invalid.co',
            role: 'admin'
          }
        }
        expect(response).not_to redirect_to(account_path)
        expect(response).to render_template(:new)
      end

      it 'renders new when invalid role' do
        post :create, params: {
          invite: {
            email: 'invalid.co',
            role: 'super_admin'
          }
        }
        expect(response).not_to redirect_to(account_path)
        expect(response).to render_template(:new)
      end

    end
  end

  context 'when logged in as super_admin' do
    before do
      sign_in super_admin
    end

    describe 'GET #new' do
      it 'redirects to account_path' do
        get :new
        expect(response).to redirect_to(account_path)
      end

    describe 'POST #create'
      it 'should not be able to invite users' do
        expect do
          post :create, params: {
            invite: {
              email: 'valid@mail',
              role: User::ADMIN,
            }
          }
        end.not_to change(Invite, :count)

        expect(response).to redirect_to(account_path)
      end
    end
  end
end
