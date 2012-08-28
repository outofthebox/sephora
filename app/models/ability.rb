class Ability
  include CanCan::Ability

  def initialize(usuario)
    can :read, :all

    can :manage, :all unless Rails.env.production?

    return unless usuario

    if usuario.rol? :admin
      can :manage, :all
    end

  end
end
