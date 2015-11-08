FactoryGirl.define do
  to_create { |instance| instance.save }

  factory :user, class: User do
    sequence(:email) { Faker::Internet.email }
    sequence(:name) { Faker::Name.first_name }
  end
end
