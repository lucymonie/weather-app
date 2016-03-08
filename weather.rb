require 'rubygems'
require 'yahoo_weatherman'
require 'nokogiri'
require 'twilio-ruby'

#For some reason, the method 'lookup_by_location' doesn't seem to be working, so I have used 
# a fixed location (London, where I live!) for this app.
client = Weatherman::Client.new
place = client.lookup_by_woeid 44418

city = place.location['city']
country = place.location['country']
date = place.condition['date']
temperature = place.condition['temp']

d = Time.now.strftime('%D %R')
day_int = Time.now.strftime('%w').to_i
date.strftime('%w').to_i

puts "#{city} five-day weather forecast:"
place.forecasts.each do |weather_stuff|
	day = weather_stuff['date']
	weekday = day.strftime('%w').to_i
	tomorrow = day_int + 1
	dayname = day.strftime('%A')
	if weekday == day_int
		then_it_is = "today"
		elsif weekday == tomorrow
		then_it_is = "tomorrow"
		else
		then_it_is = "#{dayname}"
	end
	puts "The forecast for #{then_it_is} is #{weather_stuff['text'].downcase} with a low of #{weather_stuff['low'].to_s} degrees and a high of #{weather_stuff['high'].to_s} degrees."
end