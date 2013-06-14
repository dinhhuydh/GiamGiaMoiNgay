if Rails.env == "production"
  S3_CREDENTIALS = { 'access_key_id' => ENV['S3_KEY'],
                     'secret_access_key' => ENV['S3_SECRET'],
                     'bucket_name' => ENV["S3_BUCKET_NAME"] }
else
  S3_CREDENTIALS = YAML.load(File.read(Rails.root.join("config/s3.yml")))[Rails.env]
end
