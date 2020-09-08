class AddCodeToGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :code, :string
  end
end
