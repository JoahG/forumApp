class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  attr_accessible :content, :user_id, :post_id

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