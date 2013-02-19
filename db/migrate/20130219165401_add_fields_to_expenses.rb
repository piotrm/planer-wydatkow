class AddFieldsToExpenses < ActiveRecord::Migration
  def change
  	add_column :expenses, :amount, :integer
  	add_column :expenses, :latitude, :float
    add_column :expenses, :longitude, :float
    add_column :expenses, :user_id, :integer
    add_index :expenses, :user_id
  end
end
