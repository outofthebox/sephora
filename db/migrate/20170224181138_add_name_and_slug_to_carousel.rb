class AddNameAndSlugToCarousel < ActiveRecord::Migration
  def change
    add_column :carousels, :name, :string

    add_column :carousels, :slug, :string

  end
end
