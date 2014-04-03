class Post < ActiveRecord::Base
  require 'rufus/scheduler'
  scheduler = Rufus::Scheduler.start_new

  # update score per 1 min
  scheduler.every '1m' do
    self.all.each { |x| x.compute_score }
  end

  validates :user_id,  :presence => true
  validates :title, :presence => true,
                    :length => { :minimum => 2 }

  validates_presence_of :content

  scope :recent, order('score DESC')

  ## I don't really want posters to delete other people's comments
  # that's not fair, but if the post is deleted the comments can still
  # see the very comments ( on sth missing), that's also wierd
  # so ain't broke, don't fixj
  has_many :comments, :dependent => :destroy
  belongs_to :user

  def compute_score
    time = (Time.now - self.created_at)/3600.0 # hours
    gravity = 1.5 # the score decreases a lot faster the larger the gravity is.
    points = self.points.to_i

    score = (points - 1)/(time + 2)**gravity

    # If score is float, will be converted 0 when saving to databse.
    # So score multiplied by 1000...I am not sure that is a good way.
    # It just work. :p
    self.update_attributes(:score => score*1000)
  end
end
