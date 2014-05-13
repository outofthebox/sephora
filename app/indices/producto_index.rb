ThinkingSphinx::Index.define :producto, :with => :active_record do
  indexes nombre
  indexes nombre_real
  indexes marca.marca, :as => :marca, :sortable => true
  indexes categoria.nombre, :as => :categoria, :sortable => true
  indexes precio, :sortable => true

  has marca_id, publicado, parent_id, categoria_id
end
