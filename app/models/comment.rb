class Comment < ActiveRecord::Base
  attr_accessible :post_id, :usuario_id, :padre, :comentario, :publicado
  has_one :post
  validate :validar
  def validar
  end

  def date
    I18n.localize(self.created_at, :format => '%d de %B, %Y' )
  end
end
