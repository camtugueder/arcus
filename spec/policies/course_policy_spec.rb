require 'rails_helper'

RSpec.describe CoursePolicy, type: :policy do
  let(:teacher) { create(:user, :teacher) }
  let(:admin) { create(:user, :admin) }
  let(:student) { create(:user, :student) }
  let(:other_user) { create(:user) }
  let(:course) { create(:course, teacher: teacher) }

  subject { described_class }

  permissions :index?, :show? do
    it 'allows access to all users' do
      expect(CoursePolicy).to permit(student, course)
      expect(CoursePolicy).to permit(teacher, course)
      expect(CoursePolicy).to permit(admin, course)
      expect(CoursePolicy).to permit(other_user, course)
    end
  end

  permissions :create? do
    it 'allows teachers and admins' do
      expect(CoursePolicy).to permit(teacher)
      expect(CoursePolicy).to permit(admin)
    end

    it 'denies students and other users' do
      expect(CoursePolicy).not_to permit(student)
      expect(CoursePolicy).not_to permit(other_user)
    end
  end

  permissions :update?, :destroy? do
    it 'allows the teacher of the course and admins' do
      expect(CoursePolicy).to permit(teacher, course)
      expect(CoursePolicy).to permit(admin, course)
    end

    it 'denies other teachers' do
      other_teacher = create(:user, :teacher)
      expect(CoursePolicy).not_to permit(other_teacher, course)
    end

    it 'denies students and other users' do
      expect(CoursePolicy).not_to permit(student, course)
      expect(CoursePolicy).not_to permit(other_user, course)
    end
  end
end
