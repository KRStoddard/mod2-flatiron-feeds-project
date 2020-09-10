class AddPostIdToReplies < ActiveRecord::Migration[6.0]
  def change
    add_column :replies, :post_id, :integer
  end
end
