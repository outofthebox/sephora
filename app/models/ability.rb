class Ability
  include CanCan::Ability

  def initialize(usuario = nil)
    can :read, :all
    if usuario
    	can :manage, :all if usuario.rol? :admin
    end
  end
end
