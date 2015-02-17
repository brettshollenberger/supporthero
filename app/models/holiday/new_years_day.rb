class Holiday
  class NewYearsDay < Holiday
    def self.date_rule(options={})
      CalendarDate.where(month: 1, day: 1, year: options[:year]).first
    end
  end
end
