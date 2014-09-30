class ChangeUsuarioTriviaColumnRespuestasType < ActiveRecord::Migration
  def up
  	change_table :usuario_trivia do |t|
		  t.change :respuestas, :text
		end
  end

  def down
  end
end
