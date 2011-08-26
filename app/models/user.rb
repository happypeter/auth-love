class User < ActiveRecord::Base  
  attr_accessor :password  
  before_save :encrypt_password  
  has_many :posts
    
  validates_confirmation_of :password  
  validates_presence_of :password, :on => :create
  # I don't want: validates_presence_of :password, :on => :update
  # if a user leave the password file blank, then the passwd won't be
  # changed
  validates_presence_of :name  
  validates_uniqueness_of :name  
  before_create { generate_token(:auth_token) }
  def self.authenticate(name, password)  
    user = find_by_name(name)  
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)  
      user  
    elsif user && (user.password_hash == nil)
    # when the user lost his password, I will go to mysql and remove password_hash
    # then the user can login without password, and update his profile to give
    # a new password
      user
    else  
      nil  
    end  
  end  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    PeterMailer.password_reset(self).deliver
  end
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end  
  def encrypt_password  
    if password.present?  
      self.password_salt = BCrypt::Engine.generate_salt  
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)  
    end  
  end  
end  
