class User < ApplicationRecord
  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenyList
  has_many :taught_courses, class_name: 'Course', foreign_key: 'teacher_id'

  has_many :enrollments, foreign_key: 'student_id'
  has_many :courses, through: :enrollments, source: :course

  validates :email, presence: true
  validates :name, presence: true
end
