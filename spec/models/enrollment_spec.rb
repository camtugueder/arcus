require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  it { should belong_to(:course) }
  it { should belong_to(:user).with_foreign_key('student_id') }

  it { should validate_presence_of(:student_id) }
  it { should validate_presence_of(:course_id) }

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

  describe 'counter cache' do
    let(:course) { create(:course) }

    it 'increments the enrollments count of the course' do
      expect { create(:enrollment, course: course) }.to change { course.reload.enrollments_count }.by(1)
    end

    it 'decrements the enrollments count of the course when an enrollment is destroyed' do
      enrollment = create(:enrollment, course: course)
      expect { enrollment.destroy }.to change { course.reload.enrollments_count }.by(-1)
    end
  end
end
