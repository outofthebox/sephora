class AddApellidoCpCumpleToUsuario < ActiveRecord::Migration
  def change
    add_column :usuarios, :apellido, :string

    add_column :usuarios, :cumple, :date

    add_column :usuarios, :cp, :string

  end
end
