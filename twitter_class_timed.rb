require 'twitter'

#getting the list of favourites has a rate limit of 15 requests per 15 minutes. 1 request/minute
#unfavouriting has a rate limit of ? (same thing??????)
#gotta figure out how to find and display the rate limit
#each time you use the API for a specific thing its one iteration of calling the API. if you call it to display 200 tweets its only 1 use of the API
#if you call the API for seperate things they're all considered different counts

class UnFav

	def initialize(tokens)
		@client = Twitter::REST::Client.new do |config|
			config.consumer_key        = tokens[:consumer_key]
			config.consumer_secret     = tokens[:consumer_secret]
			config.access_token        = tokens[:access_token]
			config.access_token_secret = tokens[:access_token_secret]
		end

		@last_id = nil
		@favs = []
		@count = 3
	end

	def get_favs
		if @last_id
			@favs = @client.favorites(count: @count, max_id: @last_id)
		else
			@favs = @client.favorites(count: @count)
		end
		@last_id = @favs.last.id
		puts "last_id: #{@last_id}"
		puts "favs size: #{@favs.length}"
	end

	def remove_favs(tag)
		@favs.each do |fav|
			@client.unfavorite(fav.id) if fav.text.downcase.index(tag)
			puts "Removed: #{fav.id}"
		end
	end

	def remove_all_favs(tag)
		get_favs
		begin
			if @favs.length == @count
				remove_favs(tag)
				remove_all_favs(tag)
			else
				puts "Finished!"
			end
		rescue
			puts "Going to sleep"
			sleep 1 * 60 * 15
			remove_all_favs(tag)
		end
	end

end

tokens = {
	consumer_key: "1O4wWwGpfxggu5VhxfDKYhXWo",
	consumer_secret: "KPqjl3D0mmruau40MiGC93SkCIXKrMDLYolC8e2cOp4H6LtxwX",
	access_token: "2497111788-o3BPjp1P2MEvuYfDpdlgfEwfMSkcvocNSCAjjAf",
	access_token_secret: "s2eyfK3alMBVa6UlaCyjdvTsReQJjsEXOfEVXORHEpHqt"
}

UnFav.new(tokens).remove_all_favs('#ootd')
