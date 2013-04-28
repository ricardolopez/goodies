class User < ActiveRecord::Base
  has_many :products
  
  attr_accessible :username, :password_hash, :salt, :password, 
                  :password_confirmation, :first_name, :last_name, :avatar,
                  :email, :phone

  attr_accessor :password, :avatar

  before_save :encrypt_password

  has_attached_file :avatar, :default => "/avatars/:style/missing.png",
                      :path => "cs446/lopez/#{Rails.env}:url",
                      :styles => { :thumb => "140x140>", :medium => "200x200>", :large => "250x250>" }

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :username
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_uniqueness_of :username
  validates :email, :presence => true, :format => { :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ },
            :uniqueness => true
  validates :phone, :presence => true, :format => { :with => /^\d{10}$/ }


  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, salt)
    end
  end
  
  def self.authenticate(username, password)
  	user = find_by_username(username)
    
  	if user && (user.password_hash == BCrypt::Engine.hash_secret(password, user.salt))
      user
  	else
      nil
    end
  end

end
