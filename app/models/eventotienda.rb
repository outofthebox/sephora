class Eventotienda < ActiveRecord::Base
  attr_accessor :nombre, :horario, :descripcion, :informacion, :tienda_id
  belongs_to :tienda
end
