FactoryGirl.define do
  factory :event do
    association :event_type, factory: :event_type
    association :eventable, factory: :assignment
    association :creator, factory: :user
  end
end
