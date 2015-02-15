class CalendarDate < ActiveRecord::Base
  has_one :assignment
  has_many :availabilities

  validates_uniqueness_of :day, :scope => [:month, :year]
  validates_presence_of :month, :day, :year
  validates :month, :inclusion => { :in => (1..12).to_a }
  validate :day, :day_in_month?

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
