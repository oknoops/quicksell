class PicturePolicy < ApplicationPolicy

  def destroy?
    record.product.user == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

