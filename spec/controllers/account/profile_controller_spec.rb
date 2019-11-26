require 'rails_helper'

RSpec.describe Account::ProfilesController, type: :controller do
  render_views
  let!(:user) { create(:user) }
  let(:parameters) { { params: { id: user, user: { email: 'email123@gmil.com', first_name: 'Taras',
                                                   current_password: user.password } } } }

  before(:each) do
    sign_in user
  end

  describe '#update' do
    before do
      patch :update, parameters
    end

    it 'update user`s email and first name' do
      expect(user.reload.email).to eq('email123@gmil.com')
      expect(user.first_name).to eq('Taras')
    end
  end

  describe '#edit' do
    before do
      get :edit
    end

    it 'edit have status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
