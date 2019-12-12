require 'rails_helper'

RSpec.describe Account::OrganizationsController, type: :controller do
  render_views

  let!(:organization) { create(:organization, name: 'OldName') }
  let!(:super_admin) { create(:user, :super_admin) }
  let!(:admin) { create(:user, :admin) }


  context 'when not logged in' do
    describe 'GET #index' do
      it 'redirects to login page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #show' do
      it 'redirects to login page' do
        get :show, params: { id: organization.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #edit' do
      it 'redirects to login page' do
        get :edit, params: { id: organization.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'PATCH #update' do
      it 'redirects to login page' do
        patch :update, params: {
          organization: {
            name: 'NewName'
          },
          id: organization.id
        }

        expect(response).to redirect_to(new_user_session_path)
        expect(organization.name).not_to eq('NewName')
      end
    end

    describe 'DELETE #destroy' do
      it 'redirects to login page' do
        expect do
          delete :destroy, params: { id: organization.id }
        end.not_to change(Organization, :count)

        expect(response).to redirect_to(new_user_session_path)
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

    describe 'GET #show' do
      it 'renders show template' do
        get :show, params: { id: organization.id }
        expect(response).to be_successful
        expect(response).to render_template(:show)
      end
    end

    describe 'GET #edit' do
      it 'renders edit template' do
        get :edit, params: { id: organization.id }
        expect(response).to be_successful
        expect(response).to render_template(:edit)
      end
    end

    describe 'PATCH #update' do
      it 'updates organization name' do
        patch :update, params: {
          organization: {
            name: 'NewName'
          },
          id: organization.id
        }

        organization.reload

        expect(response).to redirect_to(account_organization_path(assigns(:organization)))
        expect(organization.name).not_to eq('OldName')
        expect(organization.name).to eq('NewName')
      end

      it 'does not updates organization name' do
        put :update, params: {
          organization: {
            name: " "
          },
          id: organization.id
        }

        organization.reload

        expect(response).to render_template(:edit)
        expect(organization.name).to eq('OldName')
      end
    end

    describe 'DELETE #destroy' do
      it 'changes organization.count' do
        expect do
          delete :destroy, params: { id: organization.id }
        end.to change(Organization, :count).by(-1)
      end
    end
  end

  context 'when loggen in ass admin' do
    before do
      sign_in admin
    end

    describe 'DELETE #destroy' do
      it 'does not changes organization.count when logged in as admin' do
        sign_in admin

        expect do
          delete :destroy, params: { id: organization.id }
        end.to change(Organization, :count).by(0)
      end
    end
  end
end
