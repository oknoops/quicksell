class PicturePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

