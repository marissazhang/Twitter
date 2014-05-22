require 'twitter'

#getting the list of favourites has a rate limit of 15 requests per 15 minutes. 1 request/minute
#unfavouriting has a rate limit of ? (same thing??????)
#gotta figure out how to find and display the rate limit
#each time you use the API for a specific thing its one iteration of calling the API. if you call it to display 200 tweets its only 1 use of the API
#if you call the API for seperate things they're all considered different counts

class UnFav

	def initialize
		@client = Twitter::REST::Client.new do |config|
			config.consumer_key        = "1O4wWwGpfxggu5VhxfDKYhXWo"
			config.consumer_secret     = "KPqjl3D0mmruau40MiGC93SkCIXKrMDLYolC8e2cOp4H6LtxwX"
			config.access_token        = "2497111788-o3BPjp1P2MEvuYfDpdlgfEwfMSkcvocNSCAjjAf"
			config.access_token_secret = "s2eyfK3alMBVa6UlaCyjdvTsReQJjsEXOfEVXORHEpHqt"
		end
	end


	def run
		count=0
		for fav in @client.favorites(count: 3)
			puts fav.id
			if fav.text.downcase.index('#ootd')
				@client.unfavorite(fav.id)
			end
			count+=1
			if count==3
				maxkey=fav.id
			end
		end

		puts "#{maxkey}!!!!"

		edit_favs(maxkey)

	end



	def edit_favs(newmax)

		if @client.favorites(count: 3, max_id: newmax).length != 3 
			puts 'returning 0'
			return 0
		end
		count=0
		for fav in @client.favorites(count: 3, max_id: newmax)
			puts fav.id
			if fav.text.downcase.index('#ootd')
				@client.unfavorite(fav.id)
			end
			count+=1
			if count==3
				maxkey=fav.id
			end
		end

		puts "#{maxkey}!!!!"
		return maxkey
	end

end

sk=UnFav.new
newkey=sk.run

done=false
while done==false do
	newkey=sk.edit_favs(newkey)
		if newkey==0
			done=true
		break
		sleep 1*60*60
	end
end
