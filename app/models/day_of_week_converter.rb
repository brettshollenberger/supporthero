class DayOfWeekConverter
  class InvalidMonth < StandardError; end

  class << self
    def convert(options={})
      DayOfWeekConverter.new(options).convert
    end
  end

  attr_accessor :month, :day, :year

  def initialize(options={})
    @month = standardize_month(options[:month])
    @day   = standardize_day(options[:day])
    @year  = standardize_year(options[:year])
  end

  # The day of week can be determined using only
  # month, day, and year information, rather than
  # performing external lookup or starting at some base
  # value and adding until we get to the right date.
  #
  # Month Code + Date + Year Code = Day of Week Code
  def convert
    day_of_week_from_code(
      month_code + day + year_code
    )
  end

private
  # Day of week codes repeat on a 7 day cycle. 
  #
  # E.g. day 8 is the same day of the week as day 1
  def day_of_week_from_code(day_of_week_code)
    day_of_week_code -= 7 until day_of_week_code < 7

    day_of_week_codes.invert[day_of_week_code]
  end

  # January & February have a slightly altered value in leap years
  def month_code
    if Calendar.leap_year?(year)
      leap_year_month_codes[month]
    else
      month_codes[month]
    end
  end

  def year_code
    years_since_leap_year = year - nearest_leap_year 

    code = leap_year_code(nearest_leap_year) + years_since_leap_year

    code -= 7 until code < 7

    code
  end

  def nearest_leap_year
    nearest = year

    nearest -= 1 until Calendar.leap_year?(nearest)

    nearest
  end

  def leap_year_code(year_code)
    year_code -= 28 until year_code < 2028

    leap_year_codes[year_code]
  end

  # While we only store 24 years, leap year codes
  # repeat on a 28-year cycle, allowing the 28th year
  # to be the same as the first year in the cycle
  def leap_year_codes
    {
      2000 => 0,
      2004 => 5,
      2008 => 3,
      2012 => 1,
      2016 => 6,
      2020 => 4,
      2024 => 2
    }
  end

  def day_of_week_codes
    {
      :sunday    => 0,
      :monday    => 1,
      :tuesday   => 2,
      :wednesday => 3,
      :thursday  => 4,
      :friday    => 5,
      :saturday  => 6
    }
  end

  def month_codes
    {
      :january   => 6,
      :february  => 2,
      :march     => 2,
      :april     => 5,
      :may       => 0,
      :june      => 3,
      :july      => 5,
      :august    => 1,
      :september => 4,
      :october   => 6,
      :november  => 2,
      :december  => 4
    }
  end

  def leap_year_month_codes
    {
      :january  => 5,
      :february => 1
    }.reverse_merge(month_codes)
  end

  def standardize_month(month)
    if month.respond_to?(:to_sym) && month_codes.keys.include?(month.downcase.to_sym)
      month.downcase.to_sym
    elsif !!(month.to_s =~ /\A[-+]?[0-9]+\z/) && !month_codes.keys[month.to_i-1].nil?
      month_codes.keys[month.to_i-1]
    else
      throw InvalidMonth
    end
  end

  def standardize_day(day)
    day.to_i
  end

  def standardize_year(year)
    year.to_i
  end
end
