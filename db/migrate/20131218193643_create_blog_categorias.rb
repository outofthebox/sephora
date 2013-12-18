class CreateBlogCategorias < ActiveRecord::Migration
  def change
    create_table :blog_categorias do |t|
      t.string :categoria
      t.timestamps
    end
  end
end
