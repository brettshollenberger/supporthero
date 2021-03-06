require "rails_helper"

describe CalendarDate do
  let(:calendar_date) { FactoryGirl.create(:calendar_date) }

  it "has a month" do
    expect(calendar_date.month).to eq 1
  end

  it "has a day" do
    expect(calendar_date.day).to eq 2
  end

  it "has a year" do
    expect(calendar_date.year).to eq 2073
  end

  it "is a leap year if year is divisible by 4 && (!divisible by 100 || divisible by 400)" do
    calendar_date.year = 2015
    expect(calendar_date.leap_year?).to be false

    calendar_date.year = 2016
    expect(calendar_date.leap_year?).to be true

    calendar_date.year = 1900
    expect(calendar_date.leap_year?).to be false

    calendar_date.year = 2000
    expect(calendar_date.leap_year?).to be true
  end

  it "has 31 days in January" do
    calendar_date.month = 1
    expect(calendar_date.days_in_month).to eq 31
  end

  it "has 28 days in February on a non-leap-year" do
    calendar_date.year = 2015
    expect(calendar_date.leap_year?).to be false

    calendar_date.month = 2
    expect(calendar_date.days_in_month).to eq 28
  end

  it "has 29 days in February on a non-leap-year" do
    calendar_date.year = 2016
    expect(calendar_date.leap_year?).to be true

    calendar_date.month = 2
    expect(calendar_date.days_in_month).to eq 29
  end

  it "has 31 days in March" do
    calendar_date.month = 3
    expect(calendar_date.days_in_month).to eq 31
  end

  it "has 30 days in April" do
    calendar_date.month = 4
    expect(calendar_date.days_in_month).to eq 30
  end

  it "has 31 days in May" do
    calendar_date.month = 5
    expect(calendar_date.days_in_month).to eq 31
  end

  it "has 30 days in June" do
    calendar_date.month = 6
    expect(calendar_date.days_in_month).to eq 30
  end

  it "has 31 days in July" do
    calendar_date.month = 7
    expect(calendar_date.days_in_month).to eq 31
  end

  it "has 31 days in August" do
    calendar_date.month = 8
    expect(calendar_date.days_in_month).to eq 31
  end

  it "has 30 days in September" do
    calendar_date.month = 9
    expect(calendar_date.days_in_month).to eq 30
  end

  it "has 31 days in October" do
    calendar_date.month = 10
    expect(calendar_date.days_in_month).to eq 31
  end

  it "has 30 days in November" do
    calendar_date.month = 11
    expect(calendar_date.days_in_month).to eq 30
  end

  it "has 31 days in December" do
    calendar_date.month = 12
    expect(calendar_date.days_in_month).to eq 31
  end

  it "is upcoming if the date is between today and 2 weeks from today" do
    expect(calendar_date.upcoming?(today=calendar_date.to_date)).to           be true
    expect(calendar_date.upcoming?(today=calendar_date.to_date - 2.weeks)).to be true
    expect(calendar_date.upcoming?(today=calendar_date.to_date - 3.weeks)).to be false
    expect(calendar_date.upcoming?(today=calendar_date.to_date - 1.year)).to  be false
    expect(calendar_date.upcoming?(today=calendar_date.to_date + 3.weeks)).to be false
  end

  describe "Assignability, Holidays & Weekends" do
    before(:all) do
      Calendar.create_dates_in_year(2015)
    end

    it "is a holiday if a holiday occurs on that day" do
      expect(CalendarDate.where(month: 1, day: 1, year: 2015).first).to     be_holiday
      expect(CalendarDate.where(month: 1, day: 2, year: 2015).first).to_not be_holiday
    end

    it "is a weekend if Saturday or Sunday" do
      monday    = CalendarDate.where(month: 1, day: 5, year: 2015).first
      tuesday   = CalendarDate.where(month: 1, day: 6, year: 2015).first
      wednesday = CalendarDate.where(month: 1, day: 7, year: 2015).first
      thursday  = CalendarDate.where(month: 1, day: 8, year: 2015).first
      friday    = CalendarDate.where(month: 1, day: 9, year: 2015).first
      saturday  = CalendarDate.where(month: 1, day: 10, year: 2015).first
      sunday    = CalendarDate.where(month: 1, day: 11, year: 2015).first

      [monday, tuesday, wednesday, thursday, friday].each do |day|
        expect(day).to_not be_weekend
      end

      [saturday, sunday].each do |day|
        expect(day).to be_weekend
      end
    end

    it "is assignable if not weekend or holiday" do
      monday = CalendarDate.where(month: 1, day: 5, year: 2015).first

      expect(monday).to be_assignable
    end

    it "is not assignable if weekend" do
      saturday  = CalendarDate.where(month: 1, day: 10, year: 2015).first

      expect(saturday).to_not be_assignable
    end

    it "is not assignable if holiday" do
      new_years_day = CalendarDate.where(month: 1, day: 1, year: 2015).first

      expect(new_years_day).to_not be_assignable
    end
  end

  describe "validations" do
    it "is valid with valid date" do
      expect(calendar_date).to be_valid
    end

    it "is invalid with no month" do
      calendar_date.month = nil
      expect(calendar_date).to_not be_valid
    end

    it "is invalid if month is less than 1" do
      calendar_date.month = 0
      expect(calendar_date).to_not be_valid
    end

    it "is invalid if month is greater than 12" do
      calendar_date.month = 13
      expect(calendar_date).to_not be_valid
    end

    it "is invalid if day is nil" do
      calendar_date.day = nil
      expect(calendar_date).to_not be_valid
    end

    it "is invalid if day is not in month" do
      calendar_date.day = 0
      expect(calendar_date).to_not be_valid

      calendar_date.month = 2
      expect(calendar_date.days_in_month).to eq 28

      calendar_date.day = 28
      expect(calendar_date).to be_valid

      calendar_date.day = 29
      expect(calendar_date).to_not be_valid
    end

    it "is invalid if year is nil" do
      calendar_date.year = nil
      expect(calendar_date).to_not be_valid
    end

    it "is invalid if a duplicate calendar date exists" do
      params = {month: 1, day: 1, year: 2015}

      CalendarDate.create(params)

      duplicate_date = CalendarDate.new(params)

      expect(duplicate_date).to_not be_valid
    end
  end
end
