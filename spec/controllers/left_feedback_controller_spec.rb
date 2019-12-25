require 'rails_helper'

RSpec.describe LeftFeedbackController, type: :controller do

  describe "GET #new" do
    it 'renders new template' do
      get :new
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    it "create new feedback" do
      expect do
        post :create, params:{
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
        post :create, params:{
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
        post :create, params:{
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
