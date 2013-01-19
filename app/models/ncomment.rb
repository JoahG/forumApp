class Ncomment < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment
  attr_accessible :comment_id, :content, :user_id
  validates_presence_of :content
  validates_length_of :content, :minimum => 1
end
