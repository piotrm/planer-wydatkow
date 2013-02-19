class AddFieldsToIncomes < ActiveRecord::Migration
  def change
  	add_column :incomes, :amount, :integer
  	add_column :incomes, :latitude, :float
    add_column :incomes, :longitude, :float
    add_column :incomes, :user_id, :integer
    add_index :incomes, :user_id
  end
end
