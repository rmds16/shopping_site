class Ability
  include CanCan::Ability

  def initialize(user)
    can [:new, :create], User
    can [:show, :update], User do |u|
      u == user
    end

  end
end
