class RemoveCommenterFromComments < ActiveRecord::Migration
  def self.up
    remove_column :comments, :commenter
  end

  def self.down
    add_column :comments, :commenter, :string
  end
end
