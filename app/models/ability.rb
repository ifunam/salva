class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    elsif user.librarian?
      can :manage, :all
      alias_action :create, :edit, :destroy, :to => :ced
      cannot :ced, User
      cannot :ced, Articlestatus
      cannot :ced, Mediatype
      cannot :ced, Country
    else
      can :read, :all
    end
  end
end
