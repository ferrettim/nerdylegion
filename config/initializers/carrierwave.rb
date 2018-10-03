require 'carrierwave/storage/fog'
include ::CarrierWave::Backgrounder::Delay

CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['DO_ID'],
    aws_secret_access_key: ENV['DO_KEY'],
    region: 'nyc3',
    endpoint: 'https://nyc3.digitaloceanspaces.com'
  }
  config.fog_directory  = 'nl1'
  config.fog_attributes = {'Cache-Control' => 'max-age=2628000',
                           'Content-Disposition' => 'attachment',
                           'Expires' => '#{1.month.from_now.httpdate}' }
end
