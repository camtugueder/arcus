if @enrollment.persisted?
  json.body  "You are enrolled in #{@enrollment.course.name}."
else
  json.body  "Error"
end