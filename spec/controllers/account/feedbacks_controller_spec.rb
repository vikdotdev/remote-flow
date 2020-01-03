require 'rails_helper'

RSpec.describe Account::FeedbacksController, type: :controller do
  let!(:user) { create(:user) }
  let!(:super_admin) { create(:user, :super_admin) }
  let!(:feedback) { create(:feedback) }
  let!(:feedback_deleted) { create(:feedback, deleted_at: '2020-01-03 20:20:20') }

  context 'when super_admin logged in' do
    before do
      sign_in super_admin
    end

    describe 'GET #index' do
      it 'renders index template' do
        get :index
        expect(response).to be_successful
      end
    end

    describe 'DELETE #destroy' do
      it 'soft delete feedback' do
        expect do
          delete :destroy, params: {
            id: feedback.id
          }
        end.to change(Feedback, :count).by(-1)
      end
      it 'really delete feedback' do
        expect do
          delete :destroy, params: {
            id: feedback_deleted.id
          }
        end.to change(Feedback.with_deleted, :count).by(-1)
      end

    end

    describe 'PATCH #restore' do
      it 'restores feedback' do
        expect do
          patch :restore, params: { id: feedback_deleted.id }
          feedback_deleted.reload
        end.to change(feedback_deleted, :deleted_at).to(nil)
      end
    end
  end

  context 'when logged in as user' do
    before do
      sign_in user
    end

    describe 'GET #index' do
      it 'renders index template' do
        get :index
        expect(response).to redirect_to(account_path)
      end
    end

    describe 'DELETE #destroy' do
      it 'renders index template' do
        expect do
          delete :destroy, params: {
            id: feedback.id
          }
        end.to change(Feedback, :count).by(0)

        expect(response).to redirect_to(account_path)
      end
    end
  end
end
