class ProductoSeccion < ActiveRecord::Base
  belongs_to :producto
  belongs_to :seccion

  before_save do 
    return false unless Producto.where(:id => self.producto_id).size
  end
end
