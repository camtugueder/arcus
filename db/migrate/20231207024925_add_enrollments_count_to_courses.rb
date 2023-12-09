class AddEnrollmentsCountToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :enrollments_count, :integer, default: 0, null: false

    Course.reset_column_information
    Course.find_each do |course|
      Course.update_counters course.id, enrollments_count: course.enrollments.length
    end
  end
end
