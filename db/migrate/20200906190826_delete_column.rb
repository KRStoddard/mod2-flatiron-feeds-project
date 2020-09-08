class DeleteColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :cohort
    add_column :users, :cohort_id, :integer
  end
end
