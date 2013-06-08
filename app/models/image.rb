class Image < ActiveRecord::Base
  attr_accessible :owner_id, :owner_type

  attr_accessible :photo
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  belongs_to :owner, polymorphic: true
end
