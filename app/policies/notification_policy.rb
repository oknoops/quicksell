class NotificationPolicy < ApplicationPolicy
  def link_through?
    true
  end
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
