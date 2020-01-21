require 'rails_helper'

RSpec.describe Account::BackgroundsController, type: :controller do
  let!(:organization) { create(:organization) }
  let!(:admin) { create(:admin, organization: organization) }
  let!(:background) { create(:background, organization: organization) }
  let!(:image) do
    Rack::Test::UploadedFile.new(
      Rails.root.join("app/assets/images/backgrounds/#{rand(1..5)}.jpg"),
      'image/jpeg'
    )
  end

  context 'when logged in' do
    before do
      sign_in admin
    end

    describe 'GET #index' do
      it 'renders index template' do
        get :index
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end
    end

    describe 'POST #create' do
      it 'changes background count by 1' do
        expect do
          post :create, params: {
            image: image
          }
        end.to change(Background, :count).by(1)
      end
    end

    describe 'DELETE #destroy' do
      it 'changes backgrounds count by -1' do
        expect do
          delete :destroy, params: { id: background.id }
        end.to change(Background, :count).by(-1)
      end
    end
  end

  context 'when not logged in' do
    describe 'GET #index' do
      it 'renders index template' do
        get :index
        expect(response).not_to render_template(:index)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'POST #create' do
      it 'redirects to login page' do
        post :create, params: { image: image }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'DELETE #destroy' do
      it 'redirects to login page' do
        expect do
          delete :destroy, params: { id: background.id }
        end.not_to change(Background, :count)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
