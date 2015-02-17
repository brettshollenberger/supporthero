class Holiday
  class VeteransDay < Holiday
    def self.date_rule(options={})
      CalendarDate.where(month: 11, day: 11, year: options[:year]).first
    end
  end
end
