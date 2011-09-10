class Comment < ActiveRecord::Base
  validates :user_id, :body,  :presence => true
  belongs_to :post
  ## for will_paginate
  cattr_reader :per_page
  has_ancestry

end
