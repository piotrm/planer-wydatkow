module UsersHelper
	def balance_class(user_balance)
		if user_balance.nil?
			"grey"
		elsif user_balance < 0
			"red"
		else
			"green"
		end
	end

	def show_balance(user_balance)
		if user_balance.nil?
			"Limit nie ustawiony"
		else
			number_to_currency(user_balance.to_f/100, :unit => "PLN")
		end	
	end
end
