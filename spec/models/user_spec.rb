require "rails_helper"

describe User do
  let(:user) { FactoryGirl.create(:user) }

  describe "validations" do
    it "is valid" do
      expect(user).to be_valid
    end

    it "is not valid without an email" do
      user.email = nil
      expect(user).to_not be_valid
    end

    it "is not valid without a first_name" do
      user.first_name = nil
      expect(user).to_not be_valid
    end

    it "is not valid without a last_name" do
      user.first_name = nil
      expect(user).to_not be_valid
    end
  end
end
