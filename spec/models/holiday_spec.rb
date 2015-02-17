require "rails_helper"

describe Holiday do
  before(:all) do
    Calendar.create_dates_in_year(2015)
  end

  def readable_holiday(holidays, name)
    holidays.select { |h| h.name == name }.first.calendar_date.readable
  end

  it "has a list of California holidays" do
    expect(Holiday.list).to eq %w(cesar_chavez_day christmas_day day_after_thanksgiving independence_day labor_day martin_luther_king_day memorial_day new_years_day presidents_day thanksgiving_day veterans_day)
  end

  it "creates holidays for a given year" do
    holidays      = Holiday.create_holidays_for_year(2015)
    holiday_names = holidays.map(&:name)

    expect(holiday_names).to eq ["Cesar Chavez Day", "Christmas Day", "Day After Thanksgiving", "Independence Day", "Labor Day", "Martin Luther King Day", "Memorial Day", "New Years Day", "Presidents Day", "Thanksgiving Day", "Veterans Day"]

    expect(readable_holiday(holidays, "New Years Day")).to eq "Thursday, January 1, 2015"
    expect(readable_holiday(holidays, "Martin Luther King Day")).to eq "Monday, January 19, 2015"
    expect(readable_holiday(holidays, "Presidents Day")).to eq "Monday, February 16, 2015"
    expect(readable_holiday(holidays, "Cesar Chavez Day")).to eq "Tuesday, March 31, 2015"
    expect(readable_holiday(holidays, "Memorial Day")).to eq "Monday, May 25, 2015"
    expect(readable_holiday(holidays, "Independence Day")).to eq "Saturday, July 4, 2015"
    expect(readable_holiday(holidays, "Labor Day")).to eq "Monday, September 7, 2015"
    expect(readable_holiday(holidays, "Veterans Day")).to eq "Wednesday, November 11, 2015"
    expect(readable_holiday(holidays, "Thanksgiving Day")).to eq "Thursday, November 26, 2015"
    expect(readable_holiday(holidays, "Day After Thanksgiving")).to eq "Friday, November 27, 2015"
    expect(readable_holiday(holidays, "Christmas Day")).to eq "Friday, December 25, 2015"
  end
end
