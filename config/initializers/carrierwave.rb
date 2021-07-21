require "carrierwave/storage/abstract"
require "carrierwave/storage/file"
require "carrierwave/storage/fog"

CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage :fog
    config.fog_provider = "fog/aws"
    config.fog_directory = Settings.aws.image.bucket
    config.fog_credentials = {
      provider: "AWS",
      aws_access_key_id: Settings.aws.access_key_id,
      aws_secret_access_key: Settings.aws.secret_access_key,
      region: Settings.aws.region,
      path_style: true,
    }

    config.asset_host = Settings.image.url
  end
end
