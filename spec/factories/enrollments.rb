FactoryBot.define do
  factory :enrollment do
    association :course
    association :user, factory: :user
  end
end
