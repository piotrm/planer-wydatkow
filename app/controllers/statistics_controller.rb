class StatisticsController < ApplicationController
	def render_statistics
		@user = current_user

		@exp = (4.weeks.ago.to_date..Date.today).map do |date| 
			e = Expense.belonging_to_user(@user.id).find_by_date(date)
			if e.nil?
				0
			else
				e.amount.to_f/100
			end
		end

		@inc = (4.weeks.ago.to_date..Date.today).map do |date| 
			i = Income.belonging_to_user(@user.id).find_by_date(date)
			if i.nil?
				0
			else
				i.amount.to_f/100
			end
		end

		@cash_flow = (4.weeks.ago.to_date..Date.today).map do |date|
			inc = Income.till_date(date).belonging_to_user(@user.id).all
			exp = Expense.till_date(date).belonging_to_user(@user.id).all

			sum = 0
			
			(0...inc.length).each do |i|
				sum = sum + inc[i].amount.to_f/100
			end

			(0...exp.length).each do |e|
				sum = sum - exp[e].amount.to_f/100
			end
			sum
		end

		@quota = (4.weeks.ago.to_date..Date.today).map do |date|
			-@user.quota.to_f/100
		end

  	@h = LazyHighCharts::HighChart.new('graph') do |f|
  		f.options[:xAxis][:categories] = (4.weeks.ago.to_date..Date.today).to_a
  		f.series(:name=>'Wydatki', :data=> @exp)
  		f.series(:name=>'Przychody', :data=> @inc)
		end
		
		@i = LazyHighCharts::HighChart.new('graph') do |f|
  		f.options[:xAxis][:categories] = (4.weeks.ago.to_date..Date.today).to_a
  		f.series(:name=>'Przeplyw gotowki', :data=> @cash_flow)
  		if !@user.quota.nil?
  			f.series(:name=>'Limit wydatkow', :data=> @quota)
  		end
		end
	end
end
