class AddColumnsToGoal < ActiveRecord::Migration[5.0]
  def change
    add_column :goals, :user_id, :integer, null: false
    add_column :goals, :title, :string, null: false
    add_column :goals, :details, :string, null: false
    add_column :goals, :visibility, :string, null: false
    add_column :goals, :finished, :string, null: false
    add_column :goals, :cheers, :integer, null: false
  end
end
