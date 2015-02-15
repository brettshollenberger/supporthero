FactoryGirl.define do
  factory :assignment do
    association :user, factory: :user
    association :calendar_date, factory: :calendar_date
  end
end
