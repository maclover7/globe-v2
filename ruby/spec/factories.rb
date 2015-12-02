FactoryGirl.define do
  to_create { |instance| instance.save }

  factory :course, class: Course do
    sequence(:description) { Faker::Lorem.paragraph }
    sequence(:name) { Faker::Name.first_name }
  end

  factory :user, class: User do
    sequence(:email) { Faker::Internet.email }
    sequence(:name) { Faker::Name.first_name }
    sequence(:token) { SecureRandom.base64(24) }
  end
end
