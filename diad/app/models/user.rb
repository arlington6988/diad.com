class User < ActiveRecord::Base
  attr_accessor :password
  validates_confirmation_of :password
  before_save :encrypt_password
  has_one :cart
  has_many :items, through: :cart
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true

def encrypt_password
  self.password_salt = BCrypt::Engine.generate_salt
  self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
end

def self.authenticate(email,password)

 user = User.where(email: email).first
 if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
  user
 else
  nil
 end
end

end
