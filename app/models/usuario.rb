class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable, :lockable

  has_and_belongs_to_many :productos

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :cp, :nombre, :apellido, :cumple

  before_create do
    self.rol = "usuario"
    self.rol = "admin" unless Usuario.count > 0
  end

  def rol? rol
    self.rol == rol.to_s
  end
end
