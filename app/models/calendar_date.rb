class CalendarDate < ActiveRecord::Base
  has_one :assignment
  has_one :holiday
  has_many :availabilities

  validates_uniqueness_of :day, :scope => [:month, :year]
  validates_presence_of :month, :day, :year
  validates :month, :inclusion => { :in => (1..12).to_a }
  validate :day, :day_in_month?

  def assignable?
    !(weekend? || holiday?)
  end

  def holiday?
    !!holiday
  end

  def weekend?
    %w(Saturday Sunday).include?(day_of_week)
  end

  def readable
    "#{day_of_week}, #{month_name.capitalize} #{day}, #{year}"
  end

  def day_of_week
    DayOfWeekConverter.convert(month: month, day: day, year: year).to_s.capitalize
  end

  def leap_year?
    Calendar.leap_year?(year)
  end

  def month_name
    Calendar.month_name(month) unless month.nil?
  end

  def days_in_month
    unless month_name.nil? || year.nil?
      Calendar.days_in_month_in_year(month, year)
    end
  end

private
  def day_in_month?
    if days_in_month.nil? || !(1..days_in_month).to_a.include?(day)
      errors.add(:day, "is not included in the current month")
    end
  end
end
