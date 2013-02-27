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
			"Czyste konto"
		else
			number_to_currency(user_balance.to_f/100, :unit => "PLN")
		end	
	end

	def show_quota_message(user)
		if user.limit_exceeded?
			"<span class=\"red\">Limit przekroczono o: #{number_to_currency((user.quota + user.cash_balance).to_f/100, :unit => "PLN ")}</span>"
		else
			"<span>Do przekroczenia limitu: <span class=\"green\">#{number_to_currency((user.quota + user.cash_balance).to_f/100, :unit => "PLN ")}</span></span>"
		end
	end
end
