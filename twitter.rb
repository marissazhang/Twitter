require 'twitter'

# class FavKiller

	#def initialize()
		client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = "1O4wWwGpfxggu5VhxfDKYhXWo"
		  config.consumer_secret     = "KPqjl3D0mmruau40MiGC93SkCIXKrMDLYolC8e2cOp4H6LtxwX"
		  config.access_token        = "2497111788-o3BPjp1P2MEvuYfDpdlgfEwfMSkcvocNSCAjjAf"
		  config.access_token_secret = "s2eyfK3alMBVa6UlaCyjdvTsReQJjsEXOfEVXORHEpHqt"
		end
	#end

# 	def show_favs
# 			for fav in client.favorites
# 				puts fav.id
# 			end
# 	end

# 	def delete_favs
# 		client.favorites.each do |fav|
# 			if fav.text.downcase.index('#ootd')
# 				client.unfavorite(fav.id)
# 			end
# 	end

# end

# end

# sk = FavKiller.new()
# sk.show_favs

# print "Enter any key to unfavorite everything with OOTD"
# key=gets.chomp

# sk.delete_favs

#prints IDs
#p client.favorites
for fav in client.favorites
	puts fav.id
end

print "Enter any key to unfavorite everything with OOTD"
key=gets.chomp

#unfavourites stuff with OOTD
client.favorites.each do |fav|
	if fav.text.downcase.index('#selfie')
		client.unfavorite(fav.id)
	end
end



#start from first 200 and go to next 200 and so on 


#use some kind of loop to loop through the twitter favourites to look for #OOTD 
#unfavourite oldest tweets first -> somehow organize all favourited tweets from oldest to newest?
#twitter IDs are chronologically ascending?



