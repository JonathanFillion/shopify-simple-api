class Article < ApplicationRecord

	validates_presence_of :title, :price, :inventory_count

end
