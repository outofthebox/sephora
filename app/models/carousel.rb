class Carousel < ActiveRecord::Base
	attr_accessor :image

	validates :name, presence: true
	validates :products, presence: true

	after_create :validate_slug

	belongs_to :animation_carousel

	has_attached_file :image, {
    :styles => { :principal => "960x399>" },
    :default_url => "//s3.amazonaws.com/sephoramexico/estatico/carousels/default_:style_producto.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

	def getProducts
		productos_ids = self.products.split(",").map(&:strip)
		Producto.where(upc: productos_ids)
	end

	def validate_slug
		if self.slug.blank?
			self.slug = self.name.parameterize+"-"+self.id.to_s if self.name.present?
			self.save
		end
	end
end
