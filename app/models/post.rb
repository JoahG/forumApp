class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  attr_accessible :content, :title, :user_id
  validates_length_of :title, :minimum => 2
  validates_length_of :content, :minimum => 5
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
