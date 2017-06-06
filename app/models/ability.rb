# Ability class for CanCanCan configuration
# https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
# Determine abilities for who can access what, when
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    # admin can see all
    # Todo: May need to review with multiple institutions
    if user.admin? or user.role_is? :admin
      can :manage, :all
    else
      # allow users to view their own profile
      can :read, :all
      can [:read], User, id: user.id
      can :reorder, Album
    end
  end
end
