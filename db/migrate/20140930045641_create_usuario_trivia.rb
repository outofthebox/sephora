class CreateUsuarioTrivia < ActiveRecord::Migration
  def change
    create_table :usuario_trivia do |t|
      t.string :nombre
      t.string :direccion
      t.string :ticket
      t.string :correo
      t.string :telefono
      t.string :respuestas

      t.timestamps
    end
  end
end
