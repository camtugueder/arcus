require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'associations' do
    it { should belong_to(:teacher).class_name('User').with_foreign_key('teacher_id') }
    it { should have_many(:enrollments).dependent(:destroy) }
    it { should have_many(:students).through(:enrollments).source(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:teacher_id) }
  end
end