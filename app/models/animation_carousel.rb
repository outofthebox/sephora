class AnimationCarousel < ActiveRecord::Base
  attr_accessor :header, :footer

  validates :name, presence: true
  after_create :validate_slug


  has_attached_file(
    :header, {
      :styles => {
        :principal => "960x399>",
        mini: "431x249>",
        producto: "300x117>",
        wishlist: "960x",
        callcenter: "960x"
      },
      :default_url => "//s3.amazonaws.com/sephoramexico/estatico/animation_carousel/header/default_:style_producto.png"
    }
  )

  has_attached_file(
    :footer, {
      :styles => {
        :principal => "960x399>",
        mini: "431x249>",
        producto: "300x117>",
        wishlist: "960x",
        callcenter: "960x"
      },
      :default_url => "//s3.amazonaws.com/sephoramexico/estatico/animation_carousel/footer/default_:style_producto.png"
    }
  )

  has_many :carousels
  accepts_nested_attributes_for :carousels#, reject_if: proc { |attributes| attributes[:productos].blank? }

  def validate_slug
    if self.slug.blank?
      self.slug = self.name.parameterize+"-"+self.id.to_s if self.name.present?
      self.save
    end
  end
end
