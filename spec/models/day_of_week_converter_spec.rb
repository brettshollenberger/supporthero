require "rails_helper"

describe DayOfWeekConverter do
  it "converts May 1, 2000 to Monday" do
    expect(DayOfWeekConverter.convert(month: "May", day: 1, year: 2000)).to eq :monday
  end

  it "converts October 4, 2000 to Wednesday" do
    expect(DayOfWeekConverter.convert(month: "October", day: 4, year: 2000)).to eq :wednesday
  end

  it "converts October 31, 2001 to Wednesday" do
    expect(DayOfWeekConverter.convert(month: 10, day: 31, year: 2001)).to eq :wednesday
  end

  it "converts February 2, 2000 to Thursday" do
    expect(DayOfWeekConverter.convert(month: 2, day: 2, year: 2000)).to eq :wednesday
  end

  it "converts January 1, 2012 to Sunday" do
    expect(DayOfWeekConverter.convert(month: 1, day: 1, year: 2012)).to eq :sunday
  end

  it "converts February 1, 2014 to Saturday" do
    expect(DayOfWeekConverter.convert(month: 2, day: 1, year: 2014)).to eq :saturday
  end

  it "converts March 3, 2089 to Thursday" do
    expect(DayOfWeekConverter.convert(month: 3, day: 3, year: 2089)).to eq :thursday
  end
end
