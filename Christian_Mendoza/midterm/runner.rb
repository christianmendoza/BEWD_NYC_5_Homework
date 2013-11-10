require_relative 'YahooWeatherApi'
require_relative 'forecast'

# hello
puts "\n"
puts "Welcome to the Weather Center."
puts "\n"
puts "Enter a location for a look at the 5 day forecast."
puts "Example: [10014] or [new york, ny] or [honolulu] or [manila]"
puts "\n"

# get input location
  location = gets.chomp

# create new weather API object
yw = YahooWeatherApi.new location

# get back results from API call
results = yw.results

# do this if there are results (no empty array)
if !results.empty?
  # set variables
  forecast_results = results["item"]["forecast"]
  city = results['location']['city']
  state = results['location']['region']
  country = results['location']['country']

  # here comes the forecast
  puts "\n"
  output = "Here's the 5 day forecast for #{city}, "

  # output state if in U.S. or Canada, otherwise just country
  if country.eql? 'United States'
    output << state
  elsif country.eql? 'Canada'
    output << state + " " + country
  else
    output << country
  end

  puts output + ":"
  puts "\n"

  # create new Forecast objects
  forecast_hash = forecast_results.collect do |w|
    w_params = { date: w['date'], high: w['high'], low: w['low'], description: w['text'] }
    Forecast.new w_params
  end  

  # print out 5 day forecast
  forecast_hash.each do |forecast|
    puts forecast
    puts "\n"
  end
else
  puts "\n"
  puts "The location provided is invalid."
end
