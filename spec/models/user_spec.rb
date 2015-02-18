require "rails_helper"

describe User do
  let(:user)            { FactoryGirl.create(:user) }
  let(:eventable)       { FactoryGirl.create(:assignment) }
  let(:event_type)      { FactoryGirl.create(:event_type) }
  let(:user2)           { FactoryGirl.create(:user) }
  let(:event)           { FactoryGirl.create(:event, eventable: eventable, event_type: event_type, creator: user) }
  let(:event_recipient) { FactoryGirl.create(:event_recipient, recipient: user2, event: event) }

  it "has many created events" do
    event_recipient

    expect(user.created_events).to include event
  end

  it "has many received events" do
    event_recipient

    expect(user2.received_events).to include event
  end

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
