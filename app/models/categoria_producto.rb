class CategoriaProducto < ActiveRecord::Base
  default_scope order("orden ASC")

  belongs_to :producto
  belongs_to :categoria

  before_save do 
    return false unless Producto.where(:id => self.producto_id).size
  end
end
