class Income < ActiveRecord::Base
	acts_as_gmappable :process_geocoding => false

	belongs_to :user

  attr_accessible :amount, :longitude, :latitude, :user_id, :date, :description

  validate :amount, :presence
  validate :amount_more_or_equals_zero

  # named_scope :this_months, :lambda {|date| :conditions => {:date => [Date.today.beginning_of_month..Date.today]}}
  scope :belonging_to_user, lambda {|user_id| where('user_id = ?', user_id)}
  scope :this_months, where('date >= ? AND date <= ?', Date.today.beginning_of_month, Date.today)
  scope :till_date, lambda {|date| where('date >= ? AND date <= ?', Date.today.beginning_of_month, date)}

  def amount_more_or_equals_zero
  	if amount < 0
  		errors.add(:amount, "nie moze byc mniejsze niz 0!")
  	end
  end
end
