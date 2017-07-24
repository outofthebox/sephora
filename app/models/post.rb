class Post < ActiveRecord::Base
  attr_accessor :content, :slug, :title,:subtitle, :extracto, :categoria_id, :tag_list, :imagen, :publicado, :visitas
  acts_as_taggable
  paginates_per 10
  has_one :categoria
  has_many :usuario

  scope :publicados, -> { where(publicado: true) }

  has_attached_file :imagen, {
    :styles => {
      :grande =>["700x400#"],
      :mediana => ["350x200#"],
      :thumb => ["150x150#"]
    }
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  def to_param
    "#{id}-#{slug}"
  end
  def increment(by = 1)
    self.visitas ||= 0
    self.visitas += by
    self.save
  end

  def date
    I18n.localize(self.created_at, :format => '%d de %B, %Y' )
  end

  before_save lambda{|w| w[:slug] = w[:title].parameterize }
end
