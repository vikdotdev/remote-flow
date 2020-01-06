require 'rails_helper'

RSpec.describe Api::V1::OrganizationsController, type: :controller do

  let!(:organization) { create(:organization) }
  let!(:admin) { create(:user, :admin) }

  describe 'GET #show' do
    it 'return organization by token' do
      request.headers['token'] = organization.token
      get :show
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    it 'create new organization' do
      post :create, params: { organization: { name: Faker::Commerce.name, logo: 'logo.png' } }
      expect(response).to have_http_status(200)
    end

    it 'create new organization with already exist name' do
      post :create, params: { organization: { name: organization.name, logo: 'logo.png' } }
      expect(response).to have_http_status(422)
    end
  end

  describe 'PUT #update' do
    it 'update organization`s name by token' do
      request.headers['token'] = organization.token
      put :update, params: { organization: { name: Faker::Commerce.name } }
      expect(response).to have_http_status(200)
    end

    it 'update organization`s name without token' do
      put :update, params: { organization: { name: Faker::Commerce.name } }
      expect(response).to have_http_status(404)
    end
  end

  describe 'GET #destroy' do
    it 'remove organization by token' do
      request.headers['token'] = organization.token
      delete :destroy
      expect(response).to have_http_status(200)
    end

    it 'remove organization without token' do
      delete :destroy
      expect(response).to have_http_status(404)
    end
  end
end
