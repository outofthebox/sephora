class Marca < ActiveRecord::Base
  attr_accessible :marca, :descripcion, :slug, :logo, :promo, :behindthebrand, :remove_promo, :remove_logo, :video, :vista
  attr_accessor :logo, :promo, :remove_promo, :remove_logo
  default_scope :order => "marca ASC"

  has_attached_file :logo, {
    :styles => { :grande => "375x65>", :normal => "200x57>", :mini => "100x29>" }
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  has_attached_file :promo, {
    :styles => { :grande => "266x266>", :normal => "170x170>", :mini => "100x100>" }
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  has_many :productos

  has_many :marca_producto
  has_many :featured, :through => :marca_producto, :class_name => "Producto", :source => :producto

  has_one :landing

  validate :validar

  before_save do
    self.slug = self.marca.parameterize if new_record?
    self.promo = nil if self.remove_promo=="1"
    self.logo = nil if self.remove_logo=="1"
  end

  def self.to_csv
    csv_string = CSV.generate do |csv|
      csv << ["id", "marca", "descripcion", "slug", "logo", "promo", "behindthebrand", "video"]
      all.each do |marca|
        csv << [marca.id, marca.marca, marca.descripcion, marca.slug, marca.logo(:grande), marca.promo, marca.behindthebrand, marca.video]
      end
    end
  end

  def self.mas_buscadas
    marcas = Marca.where("vista >= 10").order("vista DESC");
    if marcas.count < 5
      Marca.all.sample(5);
    else
      marcas
    end
  end

  def validar
    errors.add :marca, "Escribe una marca" unless self.marca.parameterize.length > 1
  end
end
