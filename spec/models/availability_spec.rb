require "rails_helper"

describe Availability do
  let(:user)          { FactoryGirl.create(:user) }
  let(:calendar_date) { CalendarDate.where(month: 1, day: 1, year: 2015).first }
  let(:availability)  { FactoryGirl.create(:availability, user: user, calendar_date: calendar_date) }

  before(:all) do
    Calendar.create_dates_in_year(2015)
  end

  it "belongs to a calendar_date" do
    expect(availability.calendar_date).to eq calendar_date
  end

  it "belongs to a user" do
    expect(availability.user).to eq user
  end

  describe "validations" do
    it "is valid" do
      expect(availability).to be_valid
    end

    it "is not valid without a user" do
      availability.user = nil
      expect(availability).to_not be_valid
    end

    it "is not valid without a calendar_date" do
      availability.calendar_date = nil
      expect(availability).to_not be_valid
    end

    it "validates unique combination of user and calendar_date" do
      params = {user: user, calendar_date: calendar_date}

      Availability.create(params)

      duplicate_availability = Availability.new(params)

      expect(duplicate_availability).to_not be_valid
    end
  end
end
