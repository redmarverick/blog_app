class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, User

    if user.role == 'admin'
      can :manage, :all
      can %i[create destroy read], [Post, Comment]
    else
      can :read, [Post, Comment]
      can :destroy, Post, author_id: user.id
      can :destroy, Comment, author_id: user.id
      can :create, Comment
      can :create, Post, author_id: user.id
    end
  end
end
