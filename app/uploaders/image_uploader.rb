class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  version :small do
    process resize_to_limit: [400, 400]
  end

  def store_dir
    "uploads/#{model.name.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
