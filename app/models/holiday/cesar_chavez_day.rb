class Holiday
  class CesarChavezDay < Holiday
    def self.date_rule(options={})
      CalendarDate.where(month: 3, day: 31, year: options[:year]).first
    end
  end
end
