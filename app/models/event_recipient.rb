class EventRecipient < ActiveRecord::Base
  belongs_to :event
  belongs_to :recipient, :class_name => "User", :foreign_key => "recipient_id"
end
