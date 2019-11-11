require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  render_views

  describe 'actions test' do
    it 'gets home page' do
      get :index

      expect(response).to be_successful
    end
  end
end
