class CalendarDate < ActiveRecord::Base
  validates_presence_of :month, :day, :year

  validates :month, :inclusion => { :in => (1..12).to_a }

  def leap_year?
    (year % 4 == 0) && (year % 100 != 0 || year % 400 == 0)
  end

  def month_name
    CalendarDate.month_names[month-1]
  end

  def days_in_month
    if month_name == "february" && leap_year?
      29
    else
      CalendarDate.canonical_days_in_month[month_name.to_sym]
    end
  end

  class << self
    def month_names
      %w(january february march april may june july august september october november december)
    end

    def canonical_days_in_month
      {
        :january   => 31,
        :february  => 28,
        :march     => 31,
        :april     => 30,
        :may       => 31,
        :june      => 30,
        :july      => 31,
        :august    => 31,
        :september => 30,
        :october   => 31,
        :november  => 30,
        :december  => 31
      }
    end
  end
end
