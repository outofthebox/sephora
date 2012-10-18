class Evento < ActiveRecord::Base
  def self.filtro tienda, fecha=nil
    eventos = self.where(:tienda => tienda)
    unless fecha.nil?
      eventos = eventos.where("DATE(eventos.fecha) = ?",fecha)
    end
    eventos
  end
end
