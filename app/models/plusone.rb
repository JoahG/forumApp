class Plusone < ActiveRecord::Base
  attr_accessible :comment_id, :user_id
  belongs_to :user
  belongs_to :comment
  validates_uniqueness_of :user_id, :scope => [:comment_id]
end
