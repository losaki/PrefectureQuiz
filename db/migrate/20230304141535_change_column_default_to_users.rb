class ChangeColumnDefaultToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :role, from: nil, to: 0
    change_column :users, :role, :integer, limit: 1
  end
end
