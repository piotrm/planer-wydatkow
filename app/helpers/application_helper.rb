module ApplicationHelper
	def quantity_class(collection)
		collection.nil? or collection.count == 0 ? "grey" : ""
	end
end
