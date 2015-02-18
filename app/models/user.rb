class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :assignments
  has_many :availabilities
  has_many :created_events, foreign_key: :creator_id, class_name: 'Event'
  has_many :event_receipts, foreign_key: :recipient_id, class_name: 'EventRecipient'
  has_many :received_events, class_name: 'Event', through: :event_receipts, source: :event

  validates_presence_of :first_name, :last_name
end
