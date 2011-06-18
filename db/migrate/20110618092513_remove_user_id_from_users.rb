class RemoveUserIdFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :user_id
  end

  def self.down
    add_column :users, :user_id, :integer
  end
end
