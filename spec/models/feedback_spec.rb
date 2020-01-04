require 'rails_helper'

RSpec.describe Feedback, type: :model do
  describe "factory specs" do
    let!(:feedback) { create(:feedback) }

    it "has factory" do
      expect(feedback).to be_persisted
    end

  end

  describe 'expect to act' do
    it 'as paranoid' do
      is_expected.to act_as_paranoid
    end
  end
end
