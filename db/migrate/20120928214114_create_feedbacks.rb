class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :nombre
      t.string :email
      t.text :comentario
      t.timestamps
    end
  end
end
