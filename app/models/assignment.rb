class Assignment < ActiveRecord::Base
  belongs_to :calendar_date
  belongs_to :user

  validates_presence_of :user, :calendar_date
  validates_uniqueness_of :calendar_date, :scope => [:user]
  validate :calendar_date, :assignable?

private
  def assignable?
    if calendar_date && !calendar_date.assignable?
      errors.add(:calendar_date, "is not assignable")
    end
  end
end
