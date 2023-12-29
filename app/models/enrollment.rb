class Enrollment < ApplicationRecord
  belongs_to :course, counter_cache: true
  belongs_to :user, foreign_key: 'student_id'

  validates :student_id, presence: true, uniqueness: { scope: :course_id, message: 'is already enrolled in this course' }
  validates :course_id, presence: true
end
