require 'rails_helper'

RSpec.describe ErrorsController, type: :controller do
  describe "GET #not_found" do
    it 'renders not_found template' do
      get :not_found
      expect(response.status).to eq(404)
      expect(response).to render_template(:not_found)
    end
  end

  describe "GET #internal_error" do
    it 'renders internal_error template' do
      get :internal_error
      expect(response.status).to eq(500)
      expect(response).to render_template(:internal_error)
    end
  end
end
