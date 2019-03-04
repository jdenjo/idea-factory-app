class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is_admin?
      can :manage, :all
    end

    alias_action :create, :read, :update, :destroy, to: :crud

    can :crud, Idea, user_id: user.id

    can :crud, Review do |review|
      puts review.user.id
      puts user.id
      review.user.id == user.id || review.idea.user.id == user.id
    end
  end
end
