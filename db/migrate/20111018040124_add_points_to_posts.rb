class AddPointsToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :points, :integer
  end

  def self.down
    remove_column :posts, :points
  end
end
