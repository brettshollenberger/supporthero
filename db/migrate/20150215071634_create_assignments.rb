class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :calendar_date_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
