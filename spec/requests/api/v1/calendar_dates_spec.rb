require 'rails_helper'

describe "Calendar Dates API :" do
  before(:all) do
    Calendar.create_dates_in_year(2015)

    @other_user = FactoryGirl.create(:user, id: 2, first_name: "User 2", last_name: "Two")

    first_month = CalendarDate.where(month: 1, year: 2015)
    first_five_days = first_month[0..4]
    next_five_days = first_month[5..9]

    first_five_days.each do |day|
      FactoryGirl.create(:availability, user: user, calendar_date: day)
      FactoryGirl.create(:assignment, user: user, calendar_date: day)
    end

    next_five_days.each do |day|
      FactoryGirl.create(:availability, user: @other_user, calendar_date: day)
      FactoryGirl.create(:assignment, user: @other_user, calendar_date: day)
    end
  end

  describe "Index Action :" do
    describe "When not logged in :" do
      before(:each) do
        get api_v1_calendar_dates_path
      end

      it "It is not a successful request" do
        expect(response).to_not be_success
      end

      it "It responds with an error message" do
        expect(json.error).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "When logged in :" do
      before(:each) do
        login(user)
      end

      describe "When no query params are passed :" do
        before(:each) do
          get api_v1_calendar_dates_path
        end

        it "It is a successful request" do
          expect(response).to be_success
        end

        it "It responds with a list of all calendar_dates" do
          expect(json.length).to eq(365)
          expect(json.first.month).to eq(1)
          expect(json.first.day_of_week).to eq("Thursday")
          expect(json.first.assignment.user.first_name).to eq user.first_name
        end
      end

      describe "When month is passed :" do
        before(:each) do
          get api_v1_calendar_dates_path(month: 1)
        end

        it "It is a successful request" do
          expect(response).to be_success
        end

        it "It responds with only calendar_dates in the given month" do
          expect(json.length).to eq(31)
        end
      end
    end
  end

  describe "Show Action :" do
    describe "When not logged in :" do
      before(:each) do
        get api_v1_calendar_date_path(CalendarDate.first)
      end

      it "It is not a successful request" do
        expect(response).to_not be_success
      end

      it "It responds with an error message" do
        expect(json.error).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "When logged in :" do
      before(:each) do
        login(user)
        get api_v1_calendar_date_path(CalendarDate.first)
      end

      it "It is a successful request" do
        expect(response).to be_success
      end

      it "It responds with the calendar date" do
        expect(json.month).to eql(CalendarDate.first.month)
      end
    end
  end
end
