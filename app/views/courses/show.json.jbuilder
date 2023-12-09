json.name @course.name
json.description @course.description
json.description @course.teacher.name
json.students_num @course.students.count
json.students @course.students do |student|
  json.name student.name
end
