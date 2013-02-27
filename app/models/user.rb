class User < ActiveRecord::Base
  has_many :incomes
  has_many :expenses

  attr_accessible :quota

  def self.from_omniauth(auth)  
    find_by_uid(auth["uid"]) || create_with_omniauth(auth)  
  end  
  
  def self.create_with_omniauth(auth)  
    create! do |user|  
      user.provider = auth["provider"]  
      user.uid = auth["uid"]  
      user.name = auth["info"]["name"]  
    end  
  end

  def current_cash_status
    sum = 0
    incomes.belonging_to_user(self.id).this_months.each do |i|
      sum += i.amount
    end

    expenses.belonging_to_user(self.id).this_months.each do |e|
      sum -= e.amount
    end

    sum
  end

  def cash_balance
    quota + current_cash_status if !quota.nil?
  end

  def limit_exceeded?
     cash_balance < 0
  end

  def self.process_quota(amount)
    ((amount.gsub(",",".").to_f*100)/100)*100
  end
end
