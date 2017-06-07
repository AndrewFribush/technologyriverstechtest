class Album < ApplicationRecord
  has_many :photos, -> { order(:order) }

  accepts_nested_attributes_for :photos
end
