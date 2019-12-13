require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  render_views

  let!(:invite) { create(:invite) }

  describe 'GET #new' do
    it 'renders new template' do
      get :new
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    it 'changes user and organization count by 1' do
      expect do
        post :create, params: {
          user: {
            first_name: 'valid_name',
            last_name: 'valid_name',
            email: 'valid@email',
            role: User::SUPER_ADMIN,
            password: 'password',
            password_confirmation: 'password',
            organization_attributes: {
              name: 'valid_organization_name'
            }
          }
        }
      end.to change(User, :count).by(1) && change(Organization, :count).by(1)
    end

    it 'renders new action on incorrect params' do
      expect do
        post :create, params: {
          user: {
            first_name: '',
            last_name: '',
            email: '',
            role: User::SUPER_ADMIN,
            password: '',
            password_confirmation: '',
            organization_attributes: {
              name: 'valid_organization_name'
            }
          }
        }
      end.not_to change(User, :count) && change(Organization, :count)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #accept' do
    it 'changes user count by 1 on valid params' do
      expect do
        post :accept, params: {
          user: {
            invite_token: invite.token,
            first_name: 'valid_name',
            last_name: 'valid_name',
            password: 'password',
            password_confirmation: 'password'
          }
        }
      end.to change(User, :count).by(1)
    end

    it 'changes does not change user count on invalid params' do
      expect do
        post :accept, params: {
          user: {
            invite_token: invite.token,
            first_name: '',
            last_name: '',
            password: '',
            password_confirmation: ''
          }
        }
      end.not_to change(User, :count)
    end
  end
end
