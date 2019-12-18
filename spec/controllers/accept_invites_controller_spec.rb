require 'rails_helper'

RSpec.describe AcceptInvitesController, type: :controller do
  render_views

  let!(:invite) { create(:invite) }

  describe 'GET #new' do
    it 'renders new template' do
      get :new
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #accept' do
    it 'changes user count by 1 on valid params' do
      expect do
        post :create, params: {
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
        post :create, params: {
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
