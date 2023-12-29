require 'rails_helper'

RSpec.describe EnrollmentPolicy, type: :policy do
  let(:student) { create(:user, :student) }
  let(:teacher) { create(:user, :teacher) }
  let(:admin) { create(:user, :admin) }
  let(:other_user) { create(:user) }  # A user with no specific role

  subject { described_class }

  permissions :create? do
    it 'allows students' do
      expect(EnrollmentPolicy).to permit(student)
    end

    it 'denies teachers' do
      expect(EnrollmentPolicy).not_to permit(teacher)
    end

    it 'denies admins' do
      expect(EnrollmentPolicy).not_to permit(admin)
    end

    it 'denies users with no specific role' do
      expect(EnrollmentPolicy).not_to permit(other_user)
    end
  end
end