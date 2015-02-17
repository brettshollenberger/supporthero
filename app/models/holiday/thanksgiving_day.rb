class Holiday
  class ThanksgivingDay < Holiday
    def self.date_rule(options={})
      CalendarDate.where(month: 11, year: options[:year]).select do |calendar_date|
        calendar_date.day_of_week == "Thursday"
      end.sort_by(&:day).fourth
    end
  end
end
