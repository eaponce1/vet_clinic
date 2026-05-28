class AppointmentPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    return false unless user

    admin_or_related_owner_or_vet?
  end

  def create?
    return false unless user

    admin_or_owner_or_vet?
  end

  def new?
    create?
  end

  def update?
    return false unless user

    admin_or_assigned_vet?
  end

  def edit?
    update?
  end

  def destroy?
    return false unless user

    admin_or_assigned_vet?
  end

  class Scope < Scope
    def resolve
      return scope.none unless user

      if user.admin?
        scope.all

      elsif user.vet?
        scope.joins(:vet)
             .where(vets: { user_id: user.id })

      elsif user.owner?
        scope.joins(pet: :owner)
             .where(owners: { user_id: user.id })

      else
        scope.none
      end
    end
  end

  private

  def admin?
    user.admin?
  end

  def admin_or_owner_or_vet?
    user.admin? || user.owner? || user.vet?
  end

  def admin_or_assigned_vet?
    user.admin? ||
      record.vet.user == user
  end

  def admin_or_related_owner_or_vet?
    user.admin? ||
      record.vet.user == user ||
      record.pet.owner.user == user
  end
end