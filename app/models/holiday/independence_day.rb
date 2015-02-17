class Holiday
  class IndependenceDay < Holiday
    def self.date_rule(options={})
      CalendarDate.where(month: 7, day: 4, year: options[:year]).first
    end
  end
end
