FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "yoda#{n}@dagobah.com" }
    password "foobar15"
  end
end
