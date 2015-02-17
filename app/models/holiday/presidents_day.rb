class Holiday
  class PresidentsDay < Holiday
    def self.date_rule(options={})
      CalendarDate.where(month: 2, year: options[:year]).select do |calendar_date|
        calendar_date.day_of_week == "Monday"
      end.sort_by(&:day).third
    end
  end
end
