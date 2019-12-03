require 'rails_helper'

RSpec.describe Account::ChannelsController, type: :controller do
  render_views

  let!(:organization) { create(:organization) }
  let!(:another_organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }
  let!(:channel) { create(:channel, name: 'Danialberg', organization: organization) }

  context 'when not logged in' do
    describe 'GET #index' do
      it 'redirects to login page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #show' do
      it 'redirects to login page' do
        get :show, params: { id: channel.id }
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
        post :create, params: { name: channel.name }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #edit' do
      it 'redirects to login page' do
        get :edit, params: { id: channel.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'PATCH #update' do
      it 'redirects to login page' do
        patch :update, params: {
            channel: {
                name: 'Theofurt'
            },
            id: channel.id
        }

        expect(response).to redirect_to(new_user_session_path)
        expect(channel.name).not_to eq('Theofurt')
        expect(channel.name).to eq('Danialberg')
      end
    end

    describe 'DELETE #destroy' do
      it 'redirects to login page' do
        expect do
          delete :destroy, params: { id: channel.id }
        end.not_to change(Channel, :count)

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
        get :show, params: { id: channel.id }
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
        get :edit, params: { id: channel.id }
        expect(response).to be_successful
        expect(response).to render_template(:edit)
      end
    end

    describe 'POST #create' do
      it 'redirects to show page' do
        expect do
          post :create, params: {
              channel: {
                  name: channel.name,
                  organization_id: channel.organization.id
              }
          }
        end.to change(Channel, :count).by(1)

        expect(response).to redirect_to(account_channel_path(assigns(:channel)))
      end

      it 'renders new template if name is blank' do
        post :create, params: {
            channel: {
                name: '',
                organization_id: channel.organization.id
            }
        }
        expect(response).to render_template(:new)
        expect(channel.name).to eq('Danialberg')
      end
    end

    describe 'PATCH #update' do
      it 'updates device name' do
        patch :update, params: {
            channel: {
                name: 'Theofurt'
            },
            id: channel.id
        }

        expect(response).to redirect_to(account_channel_path(assigns(:channel)))
        expect(assigns(:channel).name).not_to eq('Danialberg')
        expect(assigns(:channel).name).to eq('Theofurt')
      end

      it 'renders edit action on blank name' do
        patch :update, params: {
            channel: {
                name: ''
            },
            id: channel.id
        }

        expect(channel.name).to eq('Danialberg')
        expect(response).to render_template(:edit)
      end

      it 'cannot change channel organization' do
        patch :update, params: {
            channel: {
                organization_id: another_organization.id
            },
            id: channel.id
        }

        expect(assigns(:channel).organization_id).not_to eq(another_organization.id)
        expect(response).to redirect_to(account_channel_path(assigns(:channel)))
      end

    end

    describe 'DELETE #destroy' do
      it 'changes Channel.count' do
        expect do
          delete :destroy, params: { id: channel.id }
        end.to change(Channel, :count).by(-1)
      end
    end
  end
end
