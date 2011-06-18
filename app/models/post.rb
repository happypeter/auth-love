class Post < ActiveRecord::Base
  validates :user_id,  :presence => true
  validates :title, :presence => true,
                    :length => { :minimum => 5 }

  has_many :comments, :dependent => :destroy
  belongs_to :user
end
