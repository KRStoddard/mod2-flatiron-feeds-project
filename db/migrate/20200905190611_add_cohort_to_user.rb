class AddCohortToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :cohort, :string
  end
end
