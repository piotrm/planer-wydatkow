class AddDecriptionField < ActiveRecord::Migration
  def up
  	add_column :expenses, :description, :string
  	add_column :incomes, :description, :string
  end

  def down
  	remove_column :expenses, :description
  	remove_column :incomes, :description
  end
end
