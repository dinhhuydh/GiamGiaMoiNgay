class Image < ActiveRecord::Base
  attr_accessible :owner_id, :owner_type

  belongs_to :owner, polymorphic: true
end
