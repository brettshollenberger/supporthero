class CreateEventRecipients < ActiveRecord::Migration
  def change
    create_table :event_recipients do |t|
      t.integer :event_id, null: false
      t.integer :recipient_id, null: false
      t.boolean :dismissed, default: false

      t.timestamps
    end
  end
end
