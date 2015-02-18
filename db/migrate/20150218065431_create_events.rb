class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :eventable_id, null: false
      t.string :eventable_type, null: false
      t.integer :event_type_id, null: false
      t.integer :creator_id, null: false

      t.timestamps
    end
  end
end
