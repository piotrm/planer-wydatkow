class Income < ActiveRecord::Base
	acts_as_gmappable :process_geocoding => false

	belongs_to :user

  attr_accessible :amount, :longitude, :latitude, :user_id
  attr_accessor :amount

  validate :amount, :presence
  validate :amount_more_or_equals_zero

  def amount_more_or_equals_zero
  	if amount < 0
  		errors.add(:amount, "nie moze byc mniejsze niz 0!")
  	end
  end
end
