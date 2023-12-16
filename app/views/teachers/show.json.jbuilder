json.name @teacher.name
json.courses @teacher.taught_courses.order(:name) do |course|
  json.name course.name
  json.students course.enrollments.size
end
