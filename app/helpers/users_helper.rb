module UsersHelper
	def balance_class(user_balance)
		user_balance < 0 ? "red" : "green"
	end

	def show_balance(user_balance)
		number_to_currency(user_balance.to_f/100, :unit => "PLN")
	end
end
