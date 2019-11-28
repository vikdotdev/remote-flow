require 'rails_helper'

RSpec.describe Account::DevicesController, type: :controller do
  render_views

  let!(:organization) { create(:organization) }
  let!(:another_organization) { create(:organization) }
  let!(:super_admin) { create(:user, :super_admin) }
  let!(:user) { create(:user, organization: organization) }
  let!(:device) { create(:device, :active, name: 'Danialberg', organization: organization) }

  context 'when not logged in' do
    describe 'GET #index' do
      it 'redirects to login page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #show' do
      it 'redirects to login page' do
        get :show, params: { id: device.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #new' do
      it 'redirects to login page' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'POST #create' do
      it 'redirects to login page' do
        post :create, params: { name: device.name }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #edit' do
      it 'redirects to login page' do
        get :edit, params: { id: device.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'PATCH #update' do
      it 'redirects to login page' do
        patch :update, params: {
          device: {
            name: 'Theofurt'
          },
          id: device.id
        }

        expect(response).to redirect_to(new_user_session_path)
        expect(device.name).not_to eq('Theofurt')
        expect(device.name).to eq('Danialberg')
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
  end

  context 'when logged in as user' do
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
        get :show, params: { id: device.id }
        expect(response).to be_successful
        expect(response).to render_template(:show)
      end
    end

    describe 'GET #new' do
      it 'renders new template' do
        get :new
        expect(response).to render_template(:new)
      end
    end

    describe 'GET #edit' do
      it 'renders edit template' do
        get :edit, params: { id: device.id }
        expect(response).to be_successful
        expect(response).to render_template(:edit)
      end
    end

    describe 'POST #create' do
      it 'redirects to show page' do
        expect do
          post :create, params: {
            device: {
              name: device.name,
              organization_id: device.organization.id
            }
          }
        end.to change(Device, :count).by(1)

        expect(response).to redirect_to(account_device_path(assigns(:device)))
      end

      it 'renders new template if name is blank' do
        post :create, params: {
          device: {
            name: '',
            organization_id: device.organization.id
          }
        }
        expect(response).to render_template(:new)
        expect(device.name).to eq('Danialberg')
      end
    end

    describe 'PATCH #update' do
      it 'updates device name' do
        patch :update, params: {
          device: {
            name: 'Theofurt'
          },
          id: device.id
        }

        expect(response).to redirect_to(account_device_path(assigns(:device)))
        expect(assigns(:device).name).not_to eq('Danialberg')
        expect(assigns(:device).name).to eq('Theofurt')
      end

      it 'renders edit action on blank name' do
        patch :update, params: {
          device: {
            name: ''
          },
          id: device.id
        }

        expect(device.name).to eq('Danialberg')
        expect(response).to render_template(:edit)
      end

      it 'cannot change device organization' do
        patch :update, params: {
          device: {
            organization_id: another_organization.id
          },
          id: device.id
        }

        expect(assigns(:device).organization_id).not_to eq(another_organization.id)
        expect(response).to redirect_to(account_device_path(assigns(:device)))
      end

    end


    describe 'DELETE #destroy' do
      it 'changes Device.count' do
        expect do
          delete :destroy, params: { id: device.id }
        end.to change(Device, :count).by(-1)
      end
    end
  end

  context 'when logged in as super_admin' do
    before do
      sign_in super_admin
    end

    describe 'PATCH #update' do
      it 'updates device name' do
        patch :update, params: {
          device: {
            name: 'Theofurt'
          },
          id: device.id
        }

        expect(response).to redirect_to(account_device_path(assigns(:device)))
        expect(assigns(:device).name).not_to eq('Danialberg')
        expect(assigns(:device).name).to eq('Theofurt')
      end

      it 'cannot change device organization' do
        patch :update, params: {
          device: {
            organization_id: another_organization.id
          },
          id: device.id
        }

        expect(assigns(:device).organization_id).not_to eq(another_organization.id)
        expect(response).to redirect_to(account_device_path(assigns(:device)))
      end
    end


    describe 'DELETE #destroy' do
      it 'changes Device.count' do
        expect do
          delete :destroy, params: { id: device.id }
        end.to change(Device, :count).by(-1)
      end
    end
  end
end
