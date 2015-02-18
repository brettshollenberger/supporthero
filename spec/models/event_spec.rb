require "rails_helper"

describe Event do
  let(:eventable)  { FactoryGirl.create(:assignment) }
  let(:event_type) { FactoryGirl.create(:event_type) }
  let(:user)       { FactoryGirl.create(:user) }
  let(:event)      { FactoryGirl.create(:event, eventable: eventable, event_type: event_type, creator: user) }
  let(:event_recipient) { FactoryGirl.create(:event_recipient, recipient: user, event: event) }

  it "has many recipients" do
    event_recipient

    expect(event.recipients).to include user
  end

  describe "validations" do
    it "is valid" do
      expect(event).to be_valid
    end

    it "is not valid without a creator" do
      event.creator = nil
      expect(event).to_not be_valid
    end

    it "is not valid without an eventable" do
      event.eventable = nil
      expect(event).to_not be_valid
    end

    it "is not valid without an event_type" do
      event.event_type = nil
      expect(event).to_not be_valid
    end
  end
end
