class Forecast
  require 'time'
  attr_reader :date, :high, :low, :description

  def initialize (date:'', high:'', low:'', description:'')
    @date = Time.parse(date).strftime("%A, %B %-d, %Y")
    @high = high
    @low = low
    @description = description
  end

  def to_s
    "#{date}\n#{description}, High: #{high}° F, Low: #{low}° F"
  end
end
