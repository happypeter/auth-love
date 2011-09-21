class Post < ActiveRecord::Base
  validates :user_id,  :presence => true
  validates :title, :presence => true,
                    :length => { :minimum => 2 }

  ## for will_paginate
  cattr_reader :per_page
  @@per_page = 30

  ## I don't really want posters to delete other people's comments
  # that's not fair, but if the post is deleted the comments can still
  # see the very comments ( on sth missing), that's also wierd
  # so ain't broke, don't fixj
  has_many :comments, :dependent => :destroy
  belongs_to :user
  def self.search(search, page)
    paginate :per_page => 30, :page => page,
             :conditions => ['title like ?', "%#{search}%"], 
             :order => 'id DESC' #DESC: list in reverse order
  end

end
