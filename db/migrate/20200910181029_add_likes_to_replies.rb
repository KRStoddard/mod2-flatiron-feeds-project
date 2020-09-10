class AddLikesToReplies < ActiveRecord::Migration[6.0]
  def change
    add_column :replies, :likes, :integer
  end
end
