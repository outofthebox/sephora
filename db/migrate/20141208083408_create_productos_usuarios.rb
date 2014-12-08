class CreateProductosUsuarios < ActiveRecord::Migration
  def change
    create_table :productos_usuarios, id: false  do |t|
      t.references :usuario
      t.references :producto
    end
    add_index :productos_usuarios, :usuario_id
    add_index :productos_usuarios, :producto_id
  end
end