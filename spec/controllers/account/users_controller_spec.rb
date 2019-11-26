require 'rails_helper'

RSpec.describe Account::UsersController, type: :controller do
  render_views

  let!(:admin) { create(:user, :super_admin, first_name: 'Kelly', role: User::SUPER_ADMIN, organization: user.organization) }
  let!(:user) { create(:user, first_name: 'Bob') }

  context 'when super_admin logged in' do
    before do
      sign_in admin
    end

    describe 'GET #index' do
      it 'renders index template' do
        get :index
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end
    end

    describe 'GET #show' do
      it 'renders show template' do
        get :show, params: { id: user.id }
        expect(response).to be_successful
        expect(response).to render_template(:show)
      end
    end

    describe 'GET #new' do
      it 'renders new template' do
        get :new
        expect(response).to be_successful
        expect(response).to render_template(:new)
      end
    end

    describe 'GET #edit' do
      it 'renders edit template' do
        get :edit, params: { id: user.id }
        expect(response).to be_successful
        expect(response).to render_template(:edit)
      end
    end

    describe 'POST #create' do
      it 'changes user count by 1' do
        expect do
          post :create, params: {
            user: {
              first_name: user.first_name,
              last_name: user.last_name,
              email: "#{user.email}other",
              role: User::SUPER_ADMIN,
              password: 'password'
            }
          }
        end.to change(User, :count).by(1)
        expect(response).to redirect_to(account_user_path(assigns(:user)))
      end

      it 'renders new action on incorrect params' do
        post :create, params: {
          user: {
            first_name: '',
            last_name: '',
            email: '',
            role: User::SUPER_ADMIN,
            password: ''
          },
          id: user.id
        }

        expect(response).to render_template(:new)
      end
    end

    describe 'PATCH #update' do
      it 'updates user name' do
        patch :update, params: {
          user: {
            first_name: 'Jack'
          },
          id: user.id
        }

        expect(response).to redirect_to(account_user_path(assigns(:user)))
        expect(assigns(:user).first_name).not_to eq('Bob')
        expect(assigns(:user).first_name).to eq('Jack')
      end

      it 'renders edit action on incorrect params' do
        patch :update, params: {
          user: {
            first_name: ''
          },
          id: user.id
        }


        expect(response).to render_template(:edit)
      end
    end

    describe 'DELETE #destroy' do
      it 'changes user count by -1' do
        expect do
          delete :destroy, params: { id: user.id }
        end.to change(User, :count).by(-1)
        expect(response).to redirect_to(account_users_path)
      end
    end
  end

  context 'when super_admin not logged in' do
    describe 'GET #index' do
      it 'renders index template' do
        get :index
        expect(response).not_to render_template(:index)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #show' do
      it 'redirects to login page' do
        get :show, params: { id: user.id }
        expect(response).not_to redirect_to(account_user_path(user))
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #new' do
      it 'redirects to login page' do
        get :new
        expect(response).not_to render_template(:new)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'POST #create' do
      it 'redirects to login page' do
        post :create, params: { user: user }
        expect(response).not_to redirect_to(account_user_path(user))
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #edit' do
      it 'redirects to login page' do
        get :edit, params: { id: user.id }
        expect(response).not_to render_template(:edit)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'PATCH #update' do
      it 'redirects to login page' do
        patch :update, params: {
          user: {
            first_name: 'Jack'
          },
          id: user.id
        }

        expect(response).not_to redirect_to(account_user_path(user))
        expect(response).to redirect_to(new_user_session_path)
        expect(user.first_name).not_to eq('Jack')
        expect(user.first_name).to eq('Bob')
      end
    end

    describe 'DELETE #destroy' do
      it 'redirects to login page' do
        expect do
          delete :destroy, params: { id: user.id }
        end.not_to change(User, :count)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'when logged in as non-super_admin' do
    before do
      sign_in user
    end

    it 'should not be able to elevate privilages to super_admin' do
      patch :update, params: {
        user: {
          role: User::SUPER_ADMIN
        },
        id: user.id
      }

      expect(assigns(:user).role).not_to eq(User::SUPER_ADMIN)
    end

    it 'should not be able to edit super_admins' do
      patch :update, params: {
        user: {
          role: User::MANAGER
        },
        id: admin.id
      }

      expect(admin.role).to eq(User::SUPER_ADMIN)
    end

    it 'should not be able to access super_admin edit page' do
      get :edit, params: { id: admin.id }

      expect(response).to redirect_to(account_user_path(admin))
    end

    it 'should not be able to create super_admins' do
      expect do
        post :create, params: {
          user: {
            first_name: user.first_name,
            last_name: user.last_name,
            email: "#{user.email}another",
            role: User::SUPER_ADMIN,
            password: 'password'
          }
        }
      end.not_to change(User, :count)
    end
  end
end
