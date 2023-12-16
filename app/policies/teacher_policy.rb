class TeacherPolicy < ApplicationPolicy
  def index?
    user.has_role?(:admin)
  end

  def show?
    user.has_role?(:admin) || user == record
  end

  def create?
    user.has_role?(:admin)
  end

  def update?
    user.has_role?(:admin) || user == record
  end

  def destroy?
    user.has_role?(:admin) || user == record
  end

end