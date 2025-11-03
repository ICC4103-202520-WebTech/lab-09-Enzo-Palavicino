class RecipePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present?
  end
  alias_method :new?, :create?

  def update?
    user_admin? || owns_record?
  end
  alias_method :edit?, :update?

  def destroy?
    user_admin? || owns_record?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def owns_record?
    user.present? && record.respond_to?(:user) && record.user == user
  end

  def user_admin?
    user&.admin?
  end
end
