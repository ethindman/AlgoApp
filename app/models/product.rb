class Product < ActiveRecord::Base

	validates :name, :description, :price, :quantity, presence: true 

	validates :name, length: { in: 2..150 }

	validates_numericality_of :price, :quantity, greater_than: 0

end
