class YahooWeatherApi
  require 'rest-client'
  require 'json'
  require 'uri'

  attr_reader :location, :results

  YAHOO_QUERY_URL = 'http://query.yahooapis.com/v1/public/yql?q='
  QUERY = 'select location,item from weather.forecast where woeid in (select woeid from geo.places where text=) limit 1'
  FORMAT = '&format=json'

  def initialize location
    @location = location
    @results = []
    query
  end

  def query
    # put location into the query statement
    QUERY[-9] = '"' + @location + '")'
    
    # encode for url
    encoded_query = URI.escape(QUERY)

    # final url for RestClient.get
    yql_url = YAHOO_QUERY_URL + encoded_query + FORMAT

    # hash
    parsed = JSON.parse RestClient.get (yql_url)

    # check if JSON returns nil in the results, i.e. invalid location
    if !parsed['query']['results'].nil?
      # set forecast results
      @results = parsed['query']['results']['channel']
    end    
  end
end
