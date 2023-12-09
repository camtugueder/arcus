json.array! @students do |student|
  json.name student.name
  json.email student.email
end