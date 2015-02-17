require "rake"

class Holiday < ActiveRecord::Base
  class AbstractHolidayError < StandardError; end

  belongs_to :calendar_date

  class << self
    def date_rule
      raise AbstractHolidayError "Must implement date rule in subclasses"
    end

    def create_holidays_for_year(year)
      holiday_classes.map do |holiday|
        Holiday.create(calendar_date: holiday.date_rule(year: year),
                       name: holiday_class_name(holiday))
      end
    end

    def list
      holiday_files.pathmap("%n")
    end

  private
    def holiday_files
      Rake::FileList.new(Dir[File.expand_path(File.join(__FILE__, "../holiday/**/*.rb"))])
    end

    def holiday_classes
      list.map do |holiday|
        "Holiday::#{holiday.classify}".constantize
      end
    end

    def holiday_class_name(holiday_class)
      holiday_class.name.gsub(/\w*\:\:/) {}.underscore.split("_").map(&:capitalize).join(" ")
    end
  end
end
