require "rails_helper"

describe CalendarDate do
  let(:calendar_date) { FactoryGirl.create(:calendar_date) }

  it "has a month" do
    expect(calendar_date.month).to eq 1
  end

  it "has a day" do
    expect(calendar_date.day).to eq 1
  end

  it "has a year" do
    expect(calendar_date.year).to eq 2015
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

  describe "validations" do
    it "is invalid if month is less than 1" do
      calendar_date.month = 0
      expect(calendar_date).to_not be_valid
    end

    it "is invalid if month is greater than 12" do
      calendar_date.month = 13
      expect(calendar_date).to_not be_valid
    end

    it "is invalid if day is not in month" do
    end
  end
end
