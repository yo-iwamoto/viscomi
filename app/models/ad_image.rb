class AdImage < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :ad
end
