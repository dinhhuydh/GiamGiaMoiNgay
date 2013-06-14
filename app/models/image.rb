class Image < ActiveRecord::Base
  attr_accessible :owner_id, :owner_type

  attr_accessible :photo
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" },
                            :default_url => "/images/:style/missing.png",
                            :storage => :s3,
                            :s3_credentials => { :bucket => S3_CREDENTIALS['bucket_name'],
                                                 :access_key_id => S3_CREDENTIALS['access_key_id'],
                                                 :secret_access_key => S3_CREDENTIALS['secret_access_key'] }

  belongs_to :owner, polymorphic: true
end
