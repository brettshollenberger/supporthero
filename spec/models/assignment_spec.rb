require "rails_helper"

describe Assignment do
  let(:user)          { FactoryGirl.create(:user) }
  let(:calendar_date) { CalendarDate.where(month: 1, day: 1, year: 2015).first }
  let(:assignment)    { FactoryGirl.create(:assignment, user: user, calendar_date: calendar_date) }

  before(:all) do
    Calendar.create_dates_in_year(2015)
  end

  it "belongs to a user" do
    expect(assignment.user).to eq user
  end

  it "belongs to a calendar_date" do
    expect(assignment.calendar_date).to eq calendar_date
  end

  describe "validations" do
    it "is valid" do
      expect(assignment).to be_valid
    end

    it "is not valid without a user" do
      assignment.user = nil

      expect(assignment).to_not be_valid
    end

    it "is not valid without a calendar_date" do
      assignment.calendar_date = nil

      expect(assignment).to_not be_valid
    end

    it "validates unique combination of user and calendar_date" do
      params = {user: user, calendar_date: calendar_date}

      Assignment.create(params)

      duplicate_assignment = Assignment.new(params)

      expect(duplicate_assignment).to_not be_valid
    end
  end
end
