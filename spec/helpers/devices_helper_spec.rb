require 'rails_helper'

RSpec.describe DevicesHelper, type: :helper do
  let!(:organization) { create(:organization) }
  let!(:background) { create(:background, organization: organization) }
  let!(:device) { create(:device, organization: organization) }

  describe 'icon helper' do
    it 'returns image tag with fallback svg if arg is blank' do
      expect(icon('')).to eq(image_tag asset_path('fallback/default_channel_icon.svg'))
    end

    it 'returns image tag with chosen svg' do
      expect(icon('channel_icons/camera.svg')).to eq(image_tag asset_path('channel_icons/camera.svg'))
    end
  end

  describe 'background helper' do
    it 'returns random existing image path' do
      path = Rails.root.join('public').to_s + random_background(device)
      expect(Pathname.new(path)).to be_exist
    end
  end
end

