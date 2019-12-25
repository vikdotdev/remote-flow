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

  describe "POST #feedback" do
    it "create new feedback" do
      expect do
        post :feedback, params:{
          feedback:{
            name: 'Jonh',
            email: 'example@mail.com',
            message: 'Message text'
          }
        }
      end.to change(Feedback, :count).by(1)
    end

    it "cannot create new feedback with blank name" do
      expect do
        post :feedback, params:{
          feedback:{
            name: '',
            email: 'example@mail.com',
            message: 'Message text'
          }
        }
      end.to change(Feedback, :count).by(0)
    end

    it "cannot create new feedback with blank email" do
      expect do
        post :feedback, params:{
          feedback:{
            name: 'Jonh',
            email: '',
            message: 'Message text'
          }
        }
      end.to change(Feedback, :count).by(0)
    end
  end
end
