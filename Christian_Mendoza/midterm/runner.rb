require_relative 'YahooWeatherApi'
require_relative 'forecast'

# hello
puts "\nWelcome to the Weather Center"
puts "Enter a US zip code to get your 5 day forecast."

# keep prompting until 5-digit zip code is entered
until (zip_code = gets.chomp) =~ /^\d{5}$/
  puts "\nPlease enter a US zip code."
end

yw = YahooWeatherApi.new (zip_code)
results = yw.get_results

if !results.empty?
  forecast_hash = results.collect do |w|
    w_params = { date: w['date'], high: w['high'], low: w['low'], description: w['text'] }
    Forecast.new w_params
  end

  # here comes the forecast
  puts "\nHere's your 5 day forecast for zip code #{zip_code}:\n\n"

  # print out 5 day forecast
  forecast_hash.each do |forecast|
    puts forecast
    puts "\n"
  end
else
  puts "\nThe zip code you provided is invalid."
end
