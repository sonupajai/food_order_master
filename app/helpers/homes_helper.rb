module HomesHelper
	def get_star(hotel)
		@ratings=hotel.ratings.all
		@ratings_tot= Rating.where(hotel_id: hotel.id).sum(:rating_no)
        @star=(@ratings_tot.to_i/(@ratings.count*5))*5
	end
end
