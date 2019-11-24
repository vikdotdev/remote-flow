require 'rails_helper'

RSpec.describe Account::UsersController, type: :controller do
  render_views

  let!(:organization) { create(:organization) }
  let(:current_user) { build(:user, organization: organization) }
  let(:user) { build(:user, organization: organization) }

  before(:each) do
    user.current_user = current_user
    user.save
  end

  context 'when logged in' do
    before do
      sign_in user
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
        expect(response).to render_template(:show)
      end
    end

    describe 'GET #new' do
      it 'renders new template' do
        get :new, params: { id: user.id }
        expect(response).to render_template(:new)
      end
    end

    describe 'GET #edit' do
      it 'renders edit template' do
        get :edit, params: { id: user.id }
        expect(response).to render_template(:edit)
      end
    end

    describe 'POST #create' do
      let(:new_user) { build(:user, organization: organization) }

      it 'changes user count by 1' do
        expect do
          post :create, params: {
            user: {
              first_name: new_user.first_name,
              last_name: new_user.last_name,
              email: new_user.email,
              role: new_user.role,
              password: 'password'
            }
          }

        end.to change(User, :count).by(1)
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

        expect(assigns(:user).first_name).to eq('Jack')
      end
    end

    describe 'DELETE #destroy' do
      it 'changes user count by -1' do
        expect do
          delete :destroy, params: { id: user.id }
        end.to change(User, :count).by(-1)
      end
    end
  end

  context 'when not logged in' do
    describe 'GET #index'
    describe 'GET #show'
    describe 'GET #new'
    describe 'GET #edit'
    describe 'POST #create'
    describe 'PATCH #update'
    describe 'DELETE #destroy'
  end
end
