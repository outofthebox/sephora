class Categoria < ActiveRecord::Base
  acts_as_nested_set
  attr_accessible :nombre, :parent_id, :cover, :urlslug
  attr_accessor :cover

  has_attached_file :cover, {
    :styles => { :normal => "768x250>", :mini => "256x83>" }
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  has_many :productos
  has_many :categoria_producto
  has_many :productos_vinculados, :through => :categoria_producto

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
end
