class TwitterTag < ActiveRecord::Base
  validates :tweet_id, presence: true, uniqueness: true
  validates :media_url, presence: true, uniqueness: true
  validates :tweet_url, presence: true, uniqueness: true

  scope :approved, -> { where(approved: true) }

  def toggle_approve
    update_attribute(:approved, !self.approved)
  end
end
