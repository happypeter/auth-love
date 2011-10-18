class AddPointsToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :points, :integer
  end

  def self.down
    remove_column :comments, :points
  end
end
