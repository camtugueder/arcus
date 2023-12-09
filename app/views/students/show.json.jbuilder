json.name @student.name
json.courses @student.courses.order(:name) do |course|
  json.name course.name
  json.students course.enrollments.size
end
