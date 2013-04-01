class User < ActiveRecord::Base
  before_save :encrypt_password
  
  attr_accessible :username, :password_hash, :salt, :password, :password_confirmation, :first_name, :last_name, :avatar
  attr_accessor :password, :password_hash

  has_attached_file :avatar

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :username
  validates_uniqueness_of :username


  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt()
      self.password_hash = BCrypt::Engine.hash_secret(password, salt)
    end
  end
  
  def self.authenticate(username, password)
  	user = find_by_username(username)
  	if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.salt)
      user
  	else
      nil
    end
  end
end