require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  it { should belong_to(:course) }
  it { should belong_to(:user).with_foreign_key('student_id') }

  describe 'validating uniqueness of enrollment' do
    let(:user) { create(:user) }
    let(:course) { create(:course) }
    let!(:enrollment) { create(:enrollment, user: user, course: course) }

    it 'does not allow duplicate enrollments for the same course and student' do
      duplicate_enrollment = build(:enrollment, user: user, course: course)
      expect(duplicate_enrollment).not_to be_valid
      expect(duplicate_enrollment.errors[:student_id]).to include('is already enrolled in this course')
    end
  end
end