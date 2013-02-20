class AddDateToIncomeAndExpense < ActiveRecord::Migration
  def change
  	add_column :incomes, :date, :date
  	add_column :expenses, :date, :date
  end
end
