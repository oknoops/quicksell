class UserPolicy < ApplicationPolicy
  def add_money?
    true
  end

  def dashboard?
    true
  end

  def update?
    record == user
  end

  def destroy?
    record == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
