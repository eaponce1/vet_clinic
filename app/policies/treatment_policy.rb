class TreatmentPolicy < ApplicationPolicy
  def show?
    return false unless user

    admin_or_related_owner_or_vet?
  end

  def create?
    return false unless user

    admin_or_assigned_vet?
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
        scope.joins(appointment: :vet)
             .where(vets: { user_id: user.id })

      elsif user.owner?
        scope.joins(appointment: { pet: :owner })
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

  def admin_or_assigned_vet?
    user.admin? ||
      record.appointment.vet.user == user
  end

  def admin_or_related_owner_or_vet?
    user.admin? ||
      record.appointment.vet.user == user ||
      record.appointment.pet.owner.user == user
  end
end