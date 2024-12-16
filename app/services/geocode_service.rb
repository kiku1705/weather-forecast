class GeocodeService
  # convert text address to lat.lon using Geocoder Gem
  # configure gem to use different API's, intialize config in geocoder.rb
  # using default configuration
  def self.call(address)
    begin
      results = Geocoder.search(address)
      raise IOError, "Invalid Address, Please enter full address with street, city, state, country" if results.nil? || results.first.postal_code.nil?
      OpenStruct.new(
        coordinates: results.first.coordinates,
        postal_code: results.first.postal_code,
        country_code: results.first.country_code
      )
    rescue SocketError, Timeout::Error, Geocoder::OverQueryLimitError, Geocoder::RequestDenied,  Geocoder::RequestDenied, Geocoder::InvalidRequest, Geocoder::InvalidApiKey  => e
      raise e.wrapped_exception, "System failure, please check with your administrator: #{e}"
    end
  end
end
