require 'rails_helper'

RSpec.describe Account::DevicesController, type: :controller do
  render_views

  let!(:user) { create(:user) }
  let!(:device) { create(:device) }

  context 'when not logged in' do
    describe 'GET #index' do
      it 'redirects to login page' do
        get :index
        expect(response).not_to render_template(:index)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'POST #create' do
      it 'redirects to login page' do
        post :create, params: { name: device.name }
        expect(response).not_to redirect_to(account_device_path(device))
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

    describe 'DELETE #destroy' do
      it 'redirects to login page' do
        expect do
          delete :destroy, params: { id: device.id }
        end.not_to change(Device, :count)

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #show' do
      it 'redirects to login page' do
        get :show, params: { id: device.id }
        expect(response).not_to redirect_to(account_device_path(device))
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'when logged in' do
    before do
      sign_in user
    end

    describe 'GET #index' do
      it 'renders index template' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    describe 'POST #create' do
      it 'redirects to :show page' do
        post :create, params: {
          device: {
            name: device.name,
            organization_id: device.organization.id
          }
        }

        expect(response).to redirect_to(account_device_path(assigns(:device)))
      end

      it 'renders :new template if name is blank' do
        post :create, params: {
          device: {
            name: '',
            organization_id: device.organization.id
          }
        }
        expect(response).to render_template(:new)
      end

      it 'renders :new template if organization is nil' do
        post :create, params: {
          device: { name: 'Correct' }
        }
        expect(response).to render_template(:new)
      end
    end

    describe 'GET #new' do
      it 'renders :new template' do
        get :new
        expect(response).to render_template(:new)
      end
    end

    describe 'DELETE #destroy' do
      it 'changes Device.count' do
        expect do
          delete :destroy, params: { id: device.id }
        end.to change(Device, :count).by(-1)
      end
    end

    describe 'GET #show' do
      it 'renders show template' do
        get :show, params: { id: device.id }
        expect(response).to render_template(:show)
      end
    end
  end
end
