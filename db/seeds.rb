
Teacher.delete_all
Student.delete_all
Course.delete_all
Enrollment.delete_all

teacher_ids = student_ids = course_ids = []

puts "Generating teachers..."
Teacher.transaction do
  teachers = Array.new(300)
  Teacher.import [ :name ],
                 teachers.map { |t| [ Faker::Name.name ] }
  teacher_ids = (Teacher.minimum(:id)..Teacher.maximum(:id)).to_a
end

puts "Generating students..."
Student.transaction do
  students = Array.new(100_000)
  Student.import [ :name, :email, :password_digest ],
                  students.map { |s| [ Faker::Name.name,
                                       Faker::Internet.unique.email,
                                       BCrypt::Password.create(Faker::Alphanumeric.alphanumeric(number: 10), cost: 4) ]}
  student_ids = (Student.minimum(:id)..Student.maximum(:id)).to_a
end

puts "Generating courses..."
Course.transaction do
  courses = Array.new(1500)
  Course.import [ :name, :description, :teacher_id ],
                courses.map { |c| [ Faker::Company.bs,
                                    Faker::Lorem.paragraph,
                                    teacher_ids.sample ] }
  course_ids = (Course.minimum(:id)..Course.maximum(:id)).to_a
end

puts "Generating enrollments..."
Enrollment.transaction do
  enrollments_data = Array.new(100_000)
  7.times do
    Enrollment.import [ :course_id, :student_id ],
                      enrollments_data.map { |e| [ course_ids.sample,
                                                   student_ids.sample ] }
  end
end
