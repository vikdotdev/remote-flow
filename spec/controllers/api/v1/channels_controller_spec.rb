require 'rails_helper'

RSpec.describe Api::V1::ChannelsController, type: :controller do
  let!(:organization) { create(:organization) }
  let!(:admin) { create(:user, :admin) }

  describe 'GET #index' do
    it 'return organization by token' do
      request.headers['Token'] = organization.token
      get :index
      expect(response).to have_http_status(200)
      expect(response.headers).to have_key('Per-Page')
      expect(response.headers).to have_key('Total')
    end

    it 'return error by invalid token' do
      request.headers['Token'] = organization.token + 'Ruby'
      get :index
      expect(response).to have_http_status(400)
      expect(response.headers).to_not have_key('Per-Page')
      expect(response.headers).to_not have_key('Total')
    end
  end
end
