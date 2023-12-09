class Enrollment < ApplicationRecord
  belongs_to :course, counter_cache: true
  belongs_to :student
end
