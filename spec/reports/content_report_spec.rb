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
end


