class CommunityCenterImage < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :community_center
end
