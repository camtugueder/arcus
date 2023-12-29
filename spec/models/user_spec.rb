require 'rails_helper'

RSpec.describe User, type: :model do
  # Validation tests
  describe 'validations' do
    let(:user) { build(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }

    it 'is not valid with an invalid email format' do
      user.email = 'invalid_email_format'
      user.valid?
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("is invalid")
    end

    it 'is not valid without a name' do
      user.name = nil
      user.valid?
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end
  end

  # Association tests
  describe 'associations' do
    context 'when user is a teacher' do
      it { should have_many(:taught_courses).class_name('Course').with_foreign_key('teacher_id') }
    end

    context 'when user is a student' do
      it { should have_many(:enrollments).with_foreign_key('student_id') }
      it { should have_many(:courses).through(:enrollments) }
    end
  end

  describe 'roles' do
    let(:user) { create(:user) }

    it 'can have a student role' do
      user.add_role :student
      expect(user.has_role?(:student)).to be true
    end

    it 'can have a teacher role' do
      user.add_role :teacher
      expect(user.has_role?(:teacher)).to be true
    end

    it 'can have multiple roles' do
      user.add_role :teacher
      user.add_role :student
      expect(user.roles.count).to be 2
    end
  end

  describe 'Devise functionalities' do
    context 'authentication' do
      let(:user) { create(:user) }

      it 'authenticates a user with valid credentials' do
        authenticated_user = User.find_for_authentication(email: user.email)
        expect(authenticated_user.valid_password?('password')).to be true
      end

      it 'does not authenticate a user with invalid credentials' do
        authenticated_user = User.find_for_authentication(email: user.email)
        expect(authenticated_user.valid_password?('wrongpassword')).to be false
      end
    end

    context 'recoverable' do
      let(:user) { create(:user) }

      it 'generates a reset password token' do
        user.send_reset_password_instructions
        expect(user.reset_password_token).to be_present
      end

      it 'changes the password with valid token' do
        user.send_reset_password_instructions

        # The last email sent should be the password reset email
        email = ActionMailer::Base.deliveries.last
        raw_token = email.body.to_s[/reset_password_token=([^"]+)/, 1]
        expect(raw_token).not_to be_nil

        # Find the user by the reset password token
        reset_user = User.with_reset_password_token(raw_token)
        expect(reset_user).not_to be_nil

        # Manually set the new password
        reset_user.password = 'newpassword123'
        reset_user.password_confirmation = 'newpassword123'
        reset_user.save!

        expect(reset_user.valid_password?('newpassword123')).to be true
      end
    end

    context 'rememberable' do
      let(:user) { create(:user) }

      it 'remembers a user when remember_me! is called' do
        user.remember_me!
        expect(user.remember_created_at).not_to be_nil
      end

      it 'forgets a user when forget_me! is called' do
        user.remember_me!
        user.forget_me!
        expect(user.remember_created_at).to be_nil
      end
    end
  end
end
