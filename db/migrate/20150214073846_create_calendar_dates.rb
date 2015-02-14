class CreateCalendarDates < ActiveRecord::Migration
  def change
    create_table :calendar_dates do |t|
      t.integer :month, :null => false
      t.integer :day, :null => false
      t.integer :year, :null => false

      t.timestamps
    end
  end
end
