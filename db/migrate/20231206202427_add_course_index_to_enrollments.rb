class AddCourseIndexToEnrollments < ActiveRecord::Migration[5.2]
  def change
    add_index(:enrollments, :course_id)
  end
end
