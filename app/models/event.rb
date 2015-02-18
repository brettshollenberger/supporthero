class Event < ActiveRecord::Base
  belongs_to :event_type
  belongs_to :eventable, polymorphic: true
  belongs_to :creator, :class_name => "User", :foreign_key => "creator_id"
  has_many   :event_recipients
  has_many   :recipients, :class_name => "User", :through => :event_recipients

  validates_presence_of :creator, :eventable, :event_type
end
