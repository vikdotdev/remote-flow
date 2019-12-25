require 'rails_helper'

RSpec.describe Feedback, type: :model do
  describe "factory specs" do
    let!(:feedback) { create(:feedback) }

    it "has factory" do
      expect(feedback).to be_persisted
    end
  end
end
