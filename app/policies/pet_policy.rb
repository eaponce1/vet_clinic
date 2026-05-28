class PetPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    return false unless user

    admin_or_pet_owner_or_vet?
  end

  def create?
    return false unless user

    admin_or_owner?
  end

  def new?
    create?
  end

  def update?
    return false unless user

    admin_or_pet_owner?
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
        scope.joins(:owner).where(owners: { user_id: user.id })
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
    user.admin? || user.owner?
  end

  def admin_or_pet_owner?
    user.admin? || record.owner.user == user
  end

  def admin_or_pet_owner_or_vet?
    user.admin? ||
      user.vet? ||
      record.owner.user == user
  end
end