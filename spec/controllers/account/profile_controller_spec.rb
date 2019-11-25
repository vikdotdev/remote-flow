require 'rails_helper'

RSpec.describe Account::ProfilesController, type: :controller do
  render_views
  let!(:user) { create(:user) }
  let(:parameters) { { params: { id: user, user: { email: 'email123@gmil.com', first_name: 'Taras',
                                                   last_name: 'Matiiv', current_password: user.password } } } }

  before(:each) do
    sign_in user

    patch :update, parameters
  end

  it 'update user`s email and first name' do
    expect(user.reload.email).to eq('email123@gmil.com')
    expect(user.first_name).to eq('Taras')
  end
end
