class Comment < ActiveRecord::Base
  attr_accessible :content, :user_id, :post_id, :comment_updated_at, :comment_updated_by
  belongs_to :user
  belongs_to :post
  has_many :ncomments
  has_many :plusones
  validates_presence_of :content
  validates_length_of :content, :minimum => 1
  before_save :test_whitespace

  private
  def test_whitespace
    if self.content.strip.length == 0
      self.content.length = 0
    end
  end
end