class Student < ApplicationRecord
  has_secure_password validations: true
  validates :email, presence: true
  validates :name, presence: true

  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments
end
