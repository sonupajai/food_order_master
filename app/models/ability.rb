class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
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
