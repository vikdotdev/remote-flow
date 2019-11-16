require 'rails_helper'

RSpec.describe Account::UsersController, type: :controller do
  render_views
  let!(:user) { create(:user, first_name: "John", last_name: "Doe") }

  before do
    sign_in user
  end

  describe 'GET /account/users' do
    it 'should show index page' do
      get :index
      expect(response).to be_successful
    end
  end
end
