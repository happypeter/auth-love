class Post < ActiveRecord::Base
  before_save :change_name  
end

def change_name

  self.name = "test"
  
end
