class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :aboutme, :sociallink, :linkedin, :twitter, :github, :gplus
  has_many :posts
  has_many :comments
  has_many :ncomments
  has_many :plusones
  has_many :notifications
  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :name
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_uniqueness_of :name
  validates :email, :presence => true, :email => true
  validates_length_of :password, :minimum => 6

  def self.authenticate(email,password)
  	user = find_by_email(email)
  	if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
  		user
  	else
  		nil
  	end
  end

  def encrypt_password
  	if password.present?
  		self.password_salt = BCrypt::Engine.generate_salt
  		self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  	end
  end
end
