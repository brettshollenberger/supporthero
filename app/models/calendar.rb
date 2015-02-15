class Calendar
  class << self
    def month_names
      %w(january february march april may june july august september october november december)
    end

    def leap_year?(year)
      (year % 4 == 0) && (year % 100 != 0 || year % 400 == 0)
    end

    def month_name(month_number)
      month_names[month_number-1]
    end

    def days_in_month_in_year(month, year)
      if month_name(month) == "february" && leap_year?(year)
        29
      else
        canonical_days_in_month[month_name(month).to_sym]
      end
    end

    def create_dates_in_year(year)
      dates_in_year(year).each do |date|
        CalendarDate.create(date)
      end
    end

    def dates_in_year(year)
      month_names.flat_map.with_index do |month_name, index|
        month_number = index + 1

        (1..days_in_month_in_year(month_number, year)).to_a.map do |day_number|
          {month: month_number, day: day_number, year: year}
        end
      end
    end

  private
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
