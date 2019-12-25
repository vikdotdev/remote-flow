require 'rails_helper'

RSpec.describe InviteReport, type: :report do
  let!(:user) { create(:admin) }

  it 'does not raise an exception on report creation' do
    expect { InviteReport.new(user) }.not_to raise_error
  end

  it 'does not raise an exception on collection method' do
    expect { InviteReport.new(user).collection }.not_to raise_error
  end

  it 'does not raise an exception on count method' do
    expect { InviteReport.new(user).count }.not_to raise_error
  end

  it 'does not raise an exception on trends method' do
    expect { InviteReport.new(user).trends }.not_to raise_error
  end

  it 'returns correct collection length' do
    expect(InviteReport.new(user).count).to eq(Invite.count)
  end

  it 'returns correct trends array lengths' do
    trends = InviteReport.new(user).trends
    expect(trends[:series_data].length).to eq(trends[:dates].length + 2)
  end
end

