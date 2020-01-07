require 'rails_helper'

RSpec.describe Api::V1::ChannelsController, type: :controller do
  let!(:organization) { create(:organization) }
  let!(:channel) { create(:channel, organization: organization) }

  describe 'GET #show' do
    it 'return channel' do
      request.headers['token'] = organization.token
      get :show, params: { id: channel.id }
      json_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json_response['id']).to eq(channel.id)
    end

    it 'return error by invalid token' do
      request.headers['token'] = organization.token + 'Ruby'
      get :show, params: { id: channel.id }
      expect(response).to have_http_status(400)
    end

    it 'return error by non exit channel' do
      request.headers['token'] = organization.token
      get :show, params: { id: 44 }
      expect(response).to have_http_status(400)
    end
  end

  describe 'POST #create' do
    it 'return new channel' do
      request.headers['token'] = organization.token
      post :create, params: {
        channel: {
          name: 'Dunder Mifflin'
        }
      }
      json_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json_response['name']).to eq('Dunder Mifflin')
    end
  end

  describe 'PATCH #update' do
    it 'return edit channel' do
      request.headers['token'] = organization.token
      patch :update, params:{
        channel:{
          name: "Sabre"
        },
        id: channel.id
      }
      channel.reload
      expect(response).to have_http_status(200)
      expect(channel.name).to eq('Sabre')
    end
  end

  describe 'PATCH #update' do
    it 'return status code 200' do
      request.headers['token'] = organization.token
      delete :destroy, params:{ id: channel.id }
      expect(response).to have_http_status(200)
    end
  end

end
