class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can [:new, :create], :all

    can [:show, :update], User do |u|
      u == user
    end
 
    can [:show], Order do |order|
      order && order.user == user
    end

    can [:update, :edit, :show, :destroy], Address do |address|
      address && address.user == user
    end
  end
end
