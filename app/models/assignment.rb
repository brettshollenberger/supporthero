class Assignment < ActiveRecord::Base
  belongs_to :calendar_date
  belongs_to :user

  validates_presence_of :user, :calendar_date
  validates_uniqueness_of :calendar_date, :scope => [:user]
end
