require "rails_helper"

describe Calendar do
  it "iterates through all calendar dates in a given year" do
    expect(Calendar.dates_in_year(2015).length).to eq 365
    expect(Calendar.dates_in_year(2016).length).to eq 366

    expect(Calendar.dates_in_year(2015).first).to eq({:month => 1, :day => 1, :year => 2015})
  end

  it "creates all dates & holidays in a given year" do
    Calendar.create_dates_in_year(2015)

    expect(CalendarDate.where(month: 1, year: 2015).length).to eq 31
    expect(Holiday.count).to eq 11
  end
end
