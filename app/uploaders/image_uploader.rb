class ImageUploader < CarrierWave::Uploader::Base
  #include Sprockets::Helpers::RailsHelper
  #include Sprockets::Helpers::IsolatedHelper

  include Cloudinary::CarrierWave

  process :tags => ["momorywell"]
  process :convert => "jpg"

  version :thumbnail do
    eager
    resize_to_fit(250, 250)
    cloudinary_transformation :quality => 80
  end

  # For more options, see
  # http://cloudinary.com/documentation/rails_integration#carrierwave

end
