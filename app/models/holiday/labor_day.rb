class Holiday
  class LaborDay < Holiday
    def self.date_rule(options={})
      CalendarDate.where(month: 9, year: options[:year]).select do |calendar_date|
        calendar_date.day_of_week == "Monday"
      end.sort_by(&:day).first
    end
  end
end
