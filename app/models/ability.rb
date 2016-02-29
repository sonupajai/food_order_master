class Ability
  include CanCan::Ability

  def initialize(user)
   
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
    user ||= User.new # guest user(not logged in)

    if user.admin?
      can :manage, :all
    elsif user.owner?
      can :read, [Area, City, DeliveryArea]
      can :read, Hotel do |hotel|
        hotel.try(:user) == user
      end
      can :read, MenuItem do |menuitem|
        menuitem.try(:user) == user
      end
     
      can :read, Menu do |menu|
        menu.try(:user) == user
      end

      can :create, [Area, DeliveryArea, Hotel, MenuItem, Menu]

      can :update, DeliveryArea do |deliveryarea|
        deliveryarea.try(:user) == user
      end
       can :update, Order do |od|
        od.try(:user) == user
      end
      can :update,  Hotel do |hotel|
        hotel.try(:user) == user
      end
      can :update, MenuItem do |menuitem|
        menuitem.try(:user) == user
      end
      can :update, Menu do |menu|
        menu.try(:user) == user
      end

      can :destroy, Hotel do |hotel|
        hotel.try(:user) == user
      end
      can :destroy, MenuItem do |menuitem|
        menuitem.try(:user) == user
      end
      can :destroy, Menu do |menu|
        menu.try(:user) == user
      end

    elsif user.normal_user?
      can :read, :all
    end
  end
end
