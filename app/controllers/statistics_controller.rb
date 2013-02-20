class StatisticsController < ApplicationController
	def render_statistics
		@user = current_user
		
		# @expenses = Expense.find_all_by_user_id(@user.id)
		#@expenses_json = @expenses.to_gmaps4rails

		@incomes = Income.find_all_by_user_id(@user.id)
		@incomes_json = @incomes.to_gmaps4rails
		
	end
end
