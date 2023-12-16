FactoryBot.define do
  factory :course do
    name { Faker::Educator.course_name }
    description { Faker::Lorem.paragraph }
    enrollments_count { 0 }
    association :teacher, factory: :user

    # If you need to create courses with a specific teacher
    trait :with_specific_teacher do
      after(:build) do |course, evaluator|
        course.teacher = evaluator.teacher if evaluator.teacher
      end
    end
  end
end
