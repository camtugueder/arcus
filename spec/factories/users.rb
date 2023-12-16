FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password' }  # Assuming you are using Devise
    password_confirmation { 'password' }

    # You can also add traits for different roles if using Rolify
    trait :teacher do
      after(:create) { |user| user.add_role(:teacher) }
    end

    trait :student do
      after(:create) { |user| user.add_role(:student) }
    end
  end
end