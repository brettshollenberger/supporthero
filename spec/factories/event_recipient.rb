FactoryGirl.define do
  factory :event_recipient do
    association :event, factory: :event
    association :recipient, factory: :user
  end
end
