require 'twitter'

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
	consumer_key: "consumer key here",
	consumer_secret: "consumer secret here",
	access_token: "access token here",
	access_token_secret: "access token secret here"

UnFav.new(tokens).remove_all_favs('#ootd')
