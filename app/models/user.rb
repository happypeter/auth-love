class User < ActiveRecord::Base  
  attr_accessor :password  
  validates_confirmation_of :password  
  validates_presence_of :password, :on => :create  
  validates_presence_of :email  
  validates_uniqueness_of :email  
end  
