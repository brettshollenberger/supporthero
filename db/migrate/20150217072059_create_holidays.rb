class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.integer :calendar_date_id, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
