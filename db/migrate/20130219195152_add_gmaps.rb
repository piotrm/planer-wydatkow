class AddGmaps < ActiveRecord::Migration
  def up
  	add_column :incomes, :gmaps, :boolean
  	add_column :expenses, :gmaps, :boolean
  end

  def down
  	remove_column :incomes, :gmaps
  	remove_column :expenses, :gmaps
  end
end
