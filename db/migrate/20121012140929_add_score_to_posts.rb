class AddScoreToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :score, :integer, :default => "0"
  end
end
