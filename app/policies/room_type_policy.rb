class RoomTypePolicy < ApplicationPolicy
  
  attr_reader :user, :room_type

  def initialize(user, room_type)
    @user = user
    @room_type = room_type
  end

  def index?
    true
  end

  def create?
    user.admin? || user.operator? || user.owner?
  end

  def update?
    user.admin? || user.operator? || user.owner?
  end
end
