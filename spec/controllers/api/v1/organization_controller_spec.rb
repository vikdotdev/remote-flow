require 'rails_helper'

RSpec.describe Api::V1::OrganizationsController, type: :controller do
  let!(:organization) { create(:organization) }

  describe 'GET #show' do
    it 'return organization by token' do
      request.headers['token'] = organization.token
      get :show
      expect(response).to have_http_status(200)
    end

    it 'return :bad_request by invalid token' do
      request.headers['token'] = organization.token + 'Ruby'
      get :show
      expect(response).to have_http_status(400)
    end
  end

end
