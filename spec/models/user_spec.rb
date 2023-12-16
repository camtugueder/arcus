require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:name) }


  describe 'user roles' do
    let(:user) { create(:user) }

    it 'can have a student role' do
      user.add_role :student
      expect(user.has_role?(:student)).to be true
    end

    it 'can have a teacher role' do
      user.add_role :teacher
      expect(user.has_role?(:teacher)).to be true
    end
  end

  context 'as a teacher' do
    it { should have_many(:taught_courses).class_name('Course').with_foreign_key('teacher_id') }
  end

  context 'as a student' do
    it { should have_many(:enrollments).with_foreign_key('student_id') }
    it { should have_many(:courses).through(:enrollments) }
  end

end