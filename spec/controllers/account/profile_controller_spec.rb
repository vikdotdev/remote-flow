require 'rails_helper'


RSpec.describe Account::ProfilesController, type: :controller do
  before(:each) do
    @user = create(:user)
    sign_in @user

    patch :update, params: { id: @user, user: { email: 'email123@gmil.com', first_name: 'Taras', last_name: 'Matiiv' } }
  end

  it 'update user`s email`' do
    expect(@user.reload.email).to eq('email123@gmil.com')
    expect(@user.reload.first_name).to eq('Taras')
  end

  it 'redirect to edit' do
    expect(response.status).to eq(302)
  end
end
