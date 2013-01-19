class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  has_many :ncomments
  attr_accessible :content, :user_id, :post_id
  validates_presence_of :content
  validates_length_of :content, :minimum => 1
  before_save :render_body
  before_save :test_whitespace

  private
  def render_body
    require 'redcarpet'
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    self.content = redcarpet.render self.content
  end

  def test_whitespace
    if self.content.strip.length == 0
      self.content.length = 0
    end
  end
end