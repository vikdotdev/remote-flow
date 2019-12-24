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
end

