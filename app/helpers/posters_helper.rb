module PostersHelper
	def poster_path contributor, content
		"/posters"
	end

	def search_posters category, condition
		p "start"
		p category
		p condition
		render "/posters/#{@server}/#{category}/#{condition}"
	end
end
