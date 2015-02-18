require "rails_helper"

describe EventType do
  let(:event_type) { FactoryGirl.create(:event_type) }

  it "has a name" do
    expect(event_type.name).to eq "request to switch"
  end

  describe "validations" do
    it "is valid" do
      expect(event_type).to be_valid
    end

    it "is not valid without a name" do
      event_type.name = nil
      expect(event_type).to_not be_valid
    end
  end
end
