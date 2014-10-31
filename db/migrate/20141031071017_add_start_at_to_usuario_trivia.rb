class AddStartAtToUsuarioTrivia < ActiveRecord::Migration
  def change
    add_column :usuario_trivia, :start_at, :datetime

  end
end
