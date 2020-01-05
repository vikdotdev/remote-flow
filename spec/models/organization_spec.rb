require 'rails_helper'

RSpec.describe Organization, type: :model do
  let!(:organization) { create(:organization) }

  describe 'factory specs' do

    it 'has factory' do
      expect(organization).to be_persisted
    end
  end

  it 'sends slack notification on organization creation' do
    notifier = class_double(SlackNotifier).as_stubbed_const(transfer_nested_constants: true)
    allow(SlackNotifier).to receive(:ping)
    expect(notifier).to receive(:ping)
    Organization.create(name: 'hey')
  end
end
