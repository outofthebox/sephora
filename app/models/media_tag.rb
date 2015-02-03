class MediaTag < ActiveRecord::Base
  attr_accessible :instagram_id, :instagram_link, :thumb_url, :pic_url, :video_url, :fullname, :username, :approved

  scope :approved, -> { where(:approved => true) }

  def self.parse data
    attributes = {
      :instagram_id => data.id,
      :instagram_link => data.link,
      :thumb_url => data.images.low_resolution.url,
      :pic_url => data.images.standard_resolution.url,
      :video_url => data.videos.try(:standard_resolution).try(:url),
      :fullname => data.user.full_name,
      :username => data.user.username
    }
    media = find_by_instagram_id(attributes[:instagram_id])
    create!(attributes) if media.nil?
  end
end
