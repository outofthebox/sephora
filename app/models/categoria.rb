require "csv"

class Categoria < ActiveRecord::Base
  acts_as_nested_set
  attr_accessor :nombre, :parent_id, :cover, :urlslug, :remove_cover, :descripcion
  attr_accessor :cover, :remove_cover

  has_attached_file :cover, {
    :styles => { :normal => "768x250>", :mini => "256x83>" }
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  has_many :productos
  has_many :categoria_producto
  has_many :productos_vinculados, :through => :categoria_producto

  scope :visible, -> { where(visible: true) }

  before_save do
    self.cover = nil if self.remove_cover=="1"
  end

  def self.by_slug slug
    self.where(:slug => slug)
  end

  def self.encontrar_marcas arr_categorias
    require 'ostruct'
    sql = <<-sql
        SELECT * FROM marcas WHERE id IN
          (SELECT DISTINCT(productos.marca_id) FROM productos WHERE publicado = true AND categoria_id IN (#{arr_categorias.join(",")})) ORDER BY marca ASC
      sql
    query = ActiveRecord::Base.connection.execute(sql)
    query.find_all.map{|q| q }
  end

  def self.to_csv
    csv_string = CSV.generate do |csv|
      csv << ["id", "nombre", "parent_id", "padre", "cover", "urlslug", "descripcion"]
      all.each do |cat|
        if cat.parent_id
          csv << [cat.id, cat.nombre, cat.parent_id, Categoria.find(cat.parent_id).nombre, cat.cover(:grande), cat.urlslug, cat.descripcion]
        else
          csv << [cat.id, cat.nombre, cat.parent_id, "padre" , cat.cover(:grande), cat.urlslug, cat.descripcion]
        end
      end
    end
  end
end
