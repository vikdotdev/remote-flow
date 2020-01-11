require 'rails_helper'

RSpec.describe DevicesController, type: :controller do
  render_views

  let!(:device) { create(:device, :with_channels) }

  describe 'factory specs' do
    it 'has channels through organization' do
      expect(device.organization.channels.count).to eq(3)
    end
  end

  describe 'GET #show' do
    it 'renders show template' do
      get :show, params: { token: device.token }
      expect(response).to be_successful
      expect(response).to render_template(:show)
    end
  end
end
