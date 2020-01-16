require 'rails_helper'

RSpec.describe DevicesHelper, type: :helper do
  it 'returns image tag with fallback svg if arg is blank' do
    expect(icon('')).to eq(image_tag asset_path('fallback/default_channel_icon.svg'))
  end

  it 'returns image tag with chosen svg' do
    expect(icon('channel_icons/camera.svg')).to eq(image_tag asset_path('channel_icons/camera.svg'))
  end
end

