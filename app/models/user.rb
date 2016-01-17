class User < ActiveRecord::Base


  attr_accessor :password

  before_save :encrypt_password
  after_save :clear_password

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.password = BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def clear_password
    self.password = nil
  end

  def self.authenticate(username = '', login_password = '')
    user = User.find_by username: username

    if user && user.match_password(login_password)
      return user
    else
      return false
    end
  end

  def match_password(login_password = '')
    encrypt_password == BCrypt::Engine.hash_secret(login_password, salt)
  end

  validates :username,
            :uniqueness => true,
            :format => {
              :multiline => true,
              :with => /^[A-z0-9]+$/
            },
            :length => {
              :in => 6..15
            }

  validates :email,
            :presence => true,
            :uniqueness => true,
            :format => {
              :multiline => true,
              :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
            }

  validates :password,
            :confirmation => true,
            :length =>{
              :minimum => 6,
            }

end