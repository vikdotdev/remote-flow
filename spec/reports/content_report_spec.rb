require 'rails_helper'

RSpec.describe ContentReport, type: :report do
  let!(:user) { create(:admin) }

  it 'does not raise an exception on report creation' do
    expect { ContentReport.new(user) }.not_to raise_error
  end

  it 'does not raise an exception on collection method' do
    expect { ContentReport.new(user).collection }.not_to raise_error
  end

  it 'does not raise an exception on count method' do
    expect { ContentReport.new(user).count }.not_to raise_error
  end

  it 'does not raise an exception on trends method' do
    expect { ContentReport.new(user).trends }.not_to raise_error
  end

  it 'returns correct collection length' do
    expect(ContentReport.new(user).count).to eq(Content.count)
  end

  it 'returns correct trends array lengths' do
    trends = ContentReport.new(user).trends
    expect(trends[:series_data].length).to eq(trends[:dates].length + 2)
  end
end


