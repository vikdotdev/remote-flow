require 'rails_helper'

RSpec.describe PublicController, type: :controller do
  render_views

  describe 'actions test' do

    it 'gets public page' do
      get :index

      expect(response).to be_successful
    end

    it 'gets pricing page' do
      get :pricing

      expect(response).to be_successful
    end

    it 'gets contact us page' do
      get :contact_us

      expect(response).to be_successful
    end
  end
end
