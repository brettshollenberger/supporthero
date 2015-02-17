class AddDayOfWeekToCalendarDate < ActiveRecord::Migration
  def change
    add_column :calendar_dates, :day_of_week, :string, null: false
  end
end
