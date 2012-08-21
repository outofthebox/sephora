class Ability
  include CanCan::Ability

  def initialize(usuario)
    can :read, :all

    return unless usuario

    if usuario.rol? :admin
      can :manage, :all
    end

  end
end
