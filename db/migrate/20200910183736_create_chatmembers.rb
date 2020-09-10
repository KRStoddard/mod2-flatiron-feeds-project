class CreateChatmembers < ActiveRecord::Migration[6.0]
  def change
    create_table :chatmembers do |t|
      t.integer :chat_id
      t.integer :user_id

      t.timestamps
    end
  end
end
