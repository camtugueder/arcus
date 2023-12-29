require 'rails_helper'

RSpec.describe StudentPolicy, type: :policy do
  let(:admin) { create(:user, :admin) }
  let(:teacher) { create(:user, :teacher) }
  let(:student) { create(:user, :student) }
  let(:other_user) { create(:user) }

  subject { described_class }

  permissions :index? do
    it 'allows admin and teacher users' do
      expect(StudentPolicy).to permit(admin)
      expect(StudentPolicy).to permit(teacher)
    end

    it 'denies students and other users' do
      expect(StudentPolicy).not_to permit(student)
      expect(StudentPolicy).not_to permit(other_user)
    end
  end

  permissions :show? do
    it 'allows admin, teacher, and the student themselves' do
      expect(StudentPolicy).to permit(admin, student)
      expect(StudentPolicy).to permit(teacher, student)
      expect(StudentPolicy).to permit(student, student)
    end

    it 'denies other users' do
      expect(StudentPolicy).not_to permit(other_user, student)
    end
  end

  permissions :create? do
    it 'allows admin' do
      expect(StudentPolicy).to permit(admin)
    end

    it 'denies teachers, students, and other users' do
      expect(StudentPolicy).not_to permit(teacher)
      expect(StudentPolicy).not_to permit(student)
      expect(StudentPolicy).not_to permit(other_user)
    end
  end

  permissions :update?, :destroy? do
    it 'allows admin and the student themselves' do
      expect(StudentPolicy).to permit(admin, student)
      expect(StudentPolicy).to permit(student, student)
    end

    it 'denies teachers and other users' do
      expect(StudentPolicy).not_to permit(teacher, student)
      expect(StudentPolicy).not_to permit(other_user, student)
    end
  end
end
