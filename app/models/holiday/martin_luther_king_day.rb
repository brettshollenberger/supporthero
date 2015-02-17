class Holiday
  class MartinLutherKingDay < Holiday
    def self.date_rule(options={})
      CalendarDate.where(month: 1, year: options[:year]).select do |calendar_date|
        calendar_date.day_of_week == "Monday"
      end.sort_by(&:day).third
    end
  end
end
