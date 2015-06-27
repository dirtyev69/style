class Painting < ActiveRecord::Base
  paginates_per 21
  attr_accessible :gallery_id, :name, :image, :remote_image_url, :item_type
  belongs_to :gallery
  mount_uploader :image, ImageUploader

  scope :ordered, -> { order("item_type ASC") }
end
