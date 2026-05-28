class OwnerPolicy < ApplicationPolicy

  def index?
    return false unless user

    user.admin? || user.vet?
  end

  def show?
    return false unless user

    admin_or_owner_or_vet?
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

    admin_or_owner?
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

      if user.admin? || user.vet?
        scope.all

      elsif user.owner?
        scope.where(user_id: user.id)

      else
        scope.none
      end
    end
  end

  private

  def admin?
    user.admin?
  end

  def admin_or_owner?
    user.admin? || record.user == user
  end

  def admin_or_owner_or_vet?
    user.admin? ||
      user.vet? ||
      record.user == user
  end
end