class Holiday
  class ChristmasDay < Holiday
    def self.date_rule(options={})
      CalendarDate.where(month: 12, day: 25, year: options[:year]).first
    end
  end
end
