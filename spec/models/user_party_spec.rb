require 'rails_helper'

RSpec.describe UserParty, type: :model do
  describe "relationships" do
    it { should belong_to :user }
    it { should belong_to :party }
  end

  describe "validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:party_id) }
  end
end
