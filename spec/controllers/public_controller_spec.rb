require 'rails_helper'

RSpec.describe PublicController, type: :controller do
  render_views

  describe 'actions test when user is not logged in' do

    it 'gets public page' do
      get :index

      expect(response).to be_successful
    end

    it 'gets pricing page' do
      get :pricing

      expect(response).to be_successful
    end
  end

  describe 'actions test when user is logged in' do
    let!(:user) { create(:user) }

    before do
      sign_in user
    end

    it 'doesnt gets public page' do
      get :index

      expect(response).not_to be_successful
    end

    it 'doesnt gets pricing page' do
      get :pricing

      expect(response).not_to be_successful
    end

  end
end
