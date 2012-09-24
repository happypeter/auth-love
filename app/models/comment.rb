class Comment < ActiveRecord::Base
  validates :user_id, :body,  :presence => true
  belongs_to :post
  belongs_to :user
  scope :recent, order('id DESC')

  has_ancestry

end
