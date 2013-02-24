class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :name, :password, :password_confirmation, :aboutme, :sociallink, :linkedin, :twitter, :github, :gplus, :admin, :moderator, :terms

  has_many :posts
  has_many :comments
  has_many :ncomments
  has_many :plusones
  has_many :notifications
  
  before_create { generate_token(:auth_token) }

  validates_acceptance_of :terms
  validates_presence_of :name
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_uniqueness_of :name
  validates :email, :presence => true, :email => true
  validates_length_of :password, :minimum => 6

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

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

  def dismiss_notifications
    if self.notifications.length > 0
      self.notifications.each do |n|
        n.destroy
      end
    end
  end
end
