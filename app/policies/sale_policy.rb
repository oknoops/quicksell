class SalePolicy < ApplicationPolicy

  def confirm?
    true
  end

  def retrieve?
    true
  end

  def moneyback?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
