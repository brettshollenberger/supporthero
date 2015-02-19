require "rails_helper"

describe EventRecipient do
  let(:eventable)  { FactoryGirl.create(:assignment) }
  let(:event_type) { FactoryGirl.create(:event_type) }
  let(:user)       { FactoryGirl.create(:user) }
  let(:event)      { FactoryGirl.create(:event, eventable: eventable, event_type: event_type, creator: user) }
  let(:event_recipient) { FactoryGirl.create(:event_recipient, recipient: user, event: event) }

  describe "validations" do
    it "is invalid with already created primary key combination" do
      event_recipient

      duplicate = FactoryGirl.build(:event_recipient, recipient: user, event: event)

      expect(duplicate).to_not be_valid
    end
  end
end
