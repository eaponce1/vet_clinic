class VetPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    return false unless user

    admin_or_vet_or_owner?
  end

  def create?
    return false unless user

    admin?
  end

  def new?
    create?
  end

  def update?
    return false unless user

    admin_or_same_vet?
  end

  def edit?
    update?
  end

  def destroy?
    return false unless user

    admin?
  end

  class Scope < Scope
    def resolve
      return scope.none unless user

      if user.admin? || user.vet? || user.owner?
        scope.all
      else
        scope.none
      end
    end
  end

  private

  def admin?
    user.admin?
  end

  def admin_or_same_vet?
    user.admin? || record.user == user
  end

  def admin_or_vet_or_owner?
    user.admin? || user.vet? || user.owner?
  end
end