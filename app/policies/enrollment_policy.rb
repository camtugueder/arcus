class EnrollmentPolicy < ApplicationPolicy
  def create?
    user.has_role?(:student)
  end
end
