namespace :calendar do
  task :add_year => :environment do
    year = ENV["YEAR"]

    if year && CalendarDate.where(:year => year).empty?
      Calendar.create_dates_in_year(year)
    end
  end
end
