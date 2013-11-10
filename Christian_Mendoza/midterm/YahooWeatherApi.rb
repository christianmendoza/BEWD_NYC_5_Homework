class YahooWeatherApi
  require 'rest-client'
  require 'json'
  require 'uri'

  attr_reader :zip_code

  YAHOO_QUERY_URL = 'http://query.yahooapis.com/v1/public/yql?q='
  QUERY = 'select item from weather.forecast where location='
  FORMAT = '&format=json'

  def initialize (zip_code)
    @zip_code = zip_code
  end

  def get_results
    encoded_query = URI.escape(QUERY + '"' + @zip_code + '"')
    rest_url = YAHOO_QUERY_URL + encoded_query + FORMAT
    results = []

    # hash
    parsed = JSON.parse RestClient.get (rest_url)

    # check if JSON returns empty forecast results, i.e. invalid zip code
    if !parsed['query']['results']['channel']['item']['description'].include? 'Invalid Input'
      results = parsed['query']['results']['channel']['item']['forecast']
    end

    results    
  end
end
