class Eventotienda < ActiveRecord::Base
  attr_accessible :nombre, :horario, :descripcion, :informacion, :tienda_id
  belongs_to :tienda
end
