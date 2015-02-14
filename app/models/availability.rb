class Availability < ActiveRecord::Base
  belongs_to :calendar_date
  belongs_to :user

  validates_presence_of :calendar_date, :user
end
