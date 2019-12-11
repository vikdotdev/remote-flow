require 'rails_helper'

RSpec.describe Account::UsersController, type: :controller do
  render_views

  let!(:super_admin) { create(:user, :super_admin, first_name: 'Kelly') }
  let!(:user) { create(:user, first_name: 'Bob') }
  let!(:manager) { create(:user, role: 'manager') }

  context 'when super_admin logged in' do
    before do
      sign_in super_admin
    end

    describe 'GET #index' do
      it 'renders index template' do
        get :index
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end
      context 'ransack search by email' do

        let!(:user) { create(:user, email: 'user2@example.com') }

        context 'finds specific user' do
          before { get :index, params: { q: { email_cont: "user2" } } }

          it "should find just one user" do
            expect(assigns(:users).first).to eq user
          end

          it { expect(response).to be_successful }
          it { expect(response).to render_template(:index) }
        end
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
  context 'when logged in as manager' do
    before do
      sign_in manager
    end

    describe "GET #index" do
      it "redirect to home page" do
        get :index
        expect(response).to redirect_to(account_path)
      end
    end

    describe "GET #show" do
      it "render show template" do
        get :show, params: { id: manager.id }
        expect(response).to be_successful
        expect(response).to render_template(:show)
      end
    end

    describe "GET #edit" do
      it "render show template" do
        get :edit, params: { id: manager.id }
        expect(response).to be_successful
        expect(response).to render_template(:edit)
      end
    end

    describe "PATCH #update" do
      it "should be able to update self" do
        patch :update, params: {
          user: {
            first_name: 'Jack'
          },
          id: manager.id
        }
        manager.reload
        expect(manager.first_name).to eq('Jack')
      end

      it "should not be able to update another user" do
        patch :update, params: {
          user: {
            first_name: 'Jack'
          },
          id: user.id
        }
        user.reload
        expect(user.first_name).not_to eq('Jack')
      end
    end

    describe "GET #new" do
      it "redirect to home page" do
        get :new
        expect(response).to redirect_to(account_path)
      end
    end

    describe "POST #create" do
      it "should not be able to create new user" do
       expect do
         post :create, params: {
           user: {
             first_name: user.first_name,
             last_name: user.last_name,
             email: "#{user.email}another",
             password: 'password'
           }
         }
       end.not_to change(User, :count)
     end
    end

    describe "POST #destroy" do
      it "should not be able to destroy another user" do
        expect do
          delete :destroy, params: { id: user.id }
        end.not_to change(User, :count)
      end
    end
  end

end
