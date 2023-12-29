require 'rails_helper'

RSpec.describe TeacherPolicy, type: :policy do
  let(:admin) { create(:user, :admin) }
  let(:teacher) { create(:user, :teacher) }
  let(:other_user) { create(:user) }

  subject { described_class }

  permissions :index? do
    it 'allows admin users' do
      expect(subject).to permit(admin)
    end

    it 'denies non-admin users' do
      expect(subject).not_to permit(teacher)
      expect(subject).not_to permit(other_user)
    end
  end

  permissions :show?, :update?, :destroy? do
    it 'allows admin users' do
      expect(subject).to permit(admin, teacher)
    end

    it 'allows the user if they are the teacher' do
      expect(subject).to permit(teacher, teacher)
    end

    it 'denies other users' do
      expect(subject).not_to permit(other_user, teacher)
    end
  end

  permissions :create? do
    it 'allows admin users' do
      expect(subject).to permit(admin)
    end

    it 'denies non-admin users' do
      expect(subject).not_to permit(teacher)
      expect(subject).not_to permit(other_user)
    end
  end
end

