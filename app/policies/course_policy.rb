class CoursePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.has_role?(:teacher) || user.has_role?(:admin)
  end

  def update?
    (user.has_role?(:teacher) && record.teacher == user) || user.has_role?(:admin)
  end

  def destroy?
    (user.has_role?(:teacher) && record.teacher == user) || user.has_role?(:admin)
  end
end