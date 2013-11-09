# require files and modules
require_relative 'forecast'
require 'rest-client'
#require 'json'
#require 'uri'

# hello
puts "\nWelcome to the Weather Center"
puts "Enter a US zip code to get your 5 day forecast."

# keep prompting until 5-digit zip code is entered
until (zip_code = gets.chomp) =~ /^\d{5}$/
  puts "\nPlease enter a US zip code."
end

# constants
YAHOO_QUERY_URL = 'http://query.yahooapis.com/v1/public/yql?q='
QUERY = 'select item from weather.forecast where location='
FORMAT = '&format=json'
ENCODED_QUERY = URI.escape(QUERY + '"' + zip_code + '"')
REST_URL = YAHOO_QUERY_URL + ENCODED_QUERY + FORMAT

# string
result = RestClient.get (REST_URL)

# hash
parsed = JSON.parse result

# check if JSON returns empty forecast results, i.e. invalid zip code
if !parsed['query']['results']['channel']['item']['description'].include? 'Invalid Input'
  # create new Forecast objects
  forecast_hash = parsed['query']['results']['channel']['item']['forecast'].collect do |w|
    w_params = { date: w['date'], high: w['high'], low: w['low'], description: w['text'] }
    Forecast.new w_params
  end

  # here comes the forecast
  puts "\nHere's your 5 day forecast for zip code #{zip_code}:\n\n"

  # print out 5 day forecast
  forecast_hash.each do |forecast|
    puts forecast
  end
else
  puts "\nThe zip code you provided is invalid."
end
