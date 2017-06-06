class Photo < ApplicationRecord
  mount_uploader :picture, ImageUploader

  belongs_to :album

  validates :picture, presence: { message: "must be provided to upload" }
end
