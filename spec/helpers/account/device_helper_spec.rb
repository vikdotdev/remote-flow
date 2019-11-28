require 'rails_helper'

RSpec.describe DeviceHelper, type: :helper do
  let!(:device) { create(:device, :active) }
  it 'returns correct html when device is active' do
    expected_html = "<div class='badge badge-light-success'>Active</div>"
    expect(status_badge(device.active)).to eq(expected_html)
  end

  it 'returns correct html when device is inactive' do
    device.active = false
    expected_html = "<div class='badge badge-light-danger'>Inactive</div>"
    expect(status_badge(device.active)).to eq(expected_html)
  end
end
