class UserPolicy < ApplicationPolicy
  def add_money?
    true
  end

  def dashboard?
    true
  end
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
