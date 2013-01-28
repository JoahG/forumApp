class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  belongs_to :forum
  attr_accessible :content, :title, :user_id, :forum_id
  validates_length_of :title, :minimum => 2
  validates_length_of :content, :minimum => 5
  before_save :test_whitespace

  private
  def test_whitespace
    if self.content.strip.length == 0
      self.content.length = 0
    end
  end
end
