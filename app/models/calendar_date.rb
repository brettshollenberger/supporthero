class CalendarDate < ActiveRecord::Base
  has_one :assignment
  has_one :holiday
  has_many :availabilities

  validates_uniqueness_of :day, :scope => [:month, :year]
  validates_presence_of :month, :day, :year
  validates :month, :inclusion => { :in => (1..12).to_a }
  validate :day, :day_in_month?

  before_create :set_day_of_week

  scope :holiday,     -> { includes(:holiday).where.not(:holidays => {:calendar_date_id => nil}) }
  scope :not_holiday, -> { includes(:holiday).where(:holidays => {:calendar_date_id => nil}) }
  scope :weekend,     -> { where("day_of_week IN (?)", weekend_days) }
  scope :not_weekend, -> { where("day_of_week NOT IN (?)", weekend_days) }
  scope :assignable,  -> { not_holiday.not_weekend }

  def self.weekend_days
    %w(Saturday Sunday)
  end

  def upcoming?(today=Date.today)
    (0..14).to_a.include?((to_date - today).numerator)
  end

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

  def to_date
    Date.new(year, month, day)
  end

private
  def day_in_month?
    if days_in_month.nil? || !(1..days_in_month).to_a.include?(day)
      errors.add(:day, "is not included in the current month")
    end
  end

  def set_day_of_week
    send("day_of_week=", DayOfWeekConverter.convert(month: month, day: day, year: year).to_s.capitalize)
  end
end
