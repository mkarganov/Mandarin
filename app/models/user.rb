class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  attr_accessor :password
  before_save :encrypt_password

  has_many :authorizations
  validates :name, :presence => :true
  validates :email, :presence => :true, :uniqueness => :true, :on => :update
  validates :email, :presence => :true, :uniqueness => :true, :on => :sign_up
  validates_confirmation_of :password
  validates :password, :presence => :true, :on => :create

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end