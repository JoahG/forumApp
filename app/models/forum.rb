class Forum < ActiveRecord::Base
  attr_accessible :title
  has_many :posts
end
