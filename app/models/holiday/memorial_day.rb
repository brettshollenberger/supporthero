class Holiday
  class MemorialDay < Holiday
    def self.date_rule(options={})
      CalendarDate.where(month: 5, year: options[:year]).select do |calendar_date|
        calendar_date.day_of_week == "Monday"
      end.sort_by(&:day).last
    end
  end
end
