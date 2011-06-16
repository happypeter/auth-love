class Post < ActiveRecord::Base
  validates :name,  :presence => true
  validates :title, :presence => true
                         
  has_many :comments
end

