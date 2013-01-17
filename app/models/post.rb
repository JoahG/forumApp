class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  attr_accessible :content, :title, :user_id

  before_save :render_body

  private
  def render_body
    require 'redcarpet'
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    self.content = redcarpet.render self.content
  end
end
