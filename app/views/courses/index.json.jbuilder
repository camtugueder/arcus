json.array! @courses do |course|
  json.name course.name
  json.students course.enrollments_count
  json.enrolled @user_courses&.include?(course.id)
end