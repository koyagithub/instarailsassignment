require 'carrierwave/storage/fog'

def use_s3?
  ENV['S3_ACCESS_KEY'] && ENV['S3_SECRET_KEY'] && ENV['S3_REGION'] && ENV['S3_BUCKET']
end

if Rails.env.production?
  CarrierWave.configure do |config|
    if use_s3?
     config.fog_credentials = {
      :provider              => 'AWS',
      :region                => ENV['ap-northeast-1'],    
      :aws_access_key_id     => ENV['S3_ACCESS_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET_KEY']
    }
     config.fog_directory     =  ENV['S3_BUCKET']
    end
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  end
end