FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "yoda#{n}@dagobah.com" }
    first_name "Yoda"
    last_name "The Great One"
    password "foobar15"
  end
end
