class SalePolicy < ApplicationPolicy

  def confirm?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
