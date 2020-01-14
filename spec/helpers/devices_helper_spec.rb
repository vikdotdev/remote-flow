require 'rails_helper'

RSpec.describe DevicesHelper, type: :helper do
  let!(:channel) { create(:channel) }

  it 'returns particular svg when path is not nil' do
    expect(icon(channel.icon.path)).to eq(File.open(channel.icon.path) { |file| raw file.read })
  end

  it 'returns default svg when path is nil' do
    svg = File.open(Rails.root.join('vendor/assets/images/default_channel_icon.svg')) do |file|
      raw file.read
    end

    expect(icon(nil)).to eq(svg)
  end
end

