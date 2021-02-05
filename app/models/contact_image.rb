class ContactImage < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :contact
end
