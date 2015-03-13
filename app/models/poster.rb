class Poster < ActiveRecord::Base
	has_many :replies
	belongs_to :server
	belongs_to :category
end
