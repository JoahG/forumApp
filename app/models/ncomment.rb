class Ncomment < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment
  attr_accessible :comment_id, :content, :user_id
end
