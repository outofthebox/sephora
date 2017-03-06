class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  after_create :signup_to_mandrill

  has_and_belongs_to_many :productos

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :cp, :nombre, :apellido, :cumple

  before_create do
    self.rol = "usuario"
    self.rol = "admin" unless Usuario.count > 0
  end

  def slug; "#{self.nombre} #{self.apellido} #{self.id}".parameterize; end

  def rol? rol
    self.rol == rol.to_s
  end

  def signup_to_mandrill
    begin
      sc = SimioCartero.new

      information = {}
      information[:NAME] = self.nombre if self.nombre.present?
      information[:EMAIL] = self.email if self.email.present?
      information[:DOB] = self.cumple.strftime("%d/%m/%Y") if self.cumple.present?
      information[:ZIP_CODE] = self.cp if self.cp.present?
      information[:REFERENCE] = "beauty-favs"

      sc.suscribe_to(information) if information[:EMAIL].present?
    rescue
      #nothing now
    end
  end
end
