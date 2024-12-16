#service to fetch weather data from openweathermap API
class WeatherForecastService < ApplicationService
  BASE_URL = 'https://api.openweathermap.org/data/2.5'.freeze
  CACHE_EXPIRATION_TIME = 30.minutes.freeze

  class << self
    # Method to fetch current weather data 
    # API params
    # required - lat, lon, appid
    # optional - modes, units and lang
    # returns weather parameters
    # in case of failure raise appropriate exception
    # if city data is not in cache save it and next time get it from cache
    # with 30 minutes expiry
    def call(location, options)
      w_cache_key = cache_key(location.country_code, location.postal_code)
      data = RedisCacheService.get_cache_data(w_cache_key)
      return JSON.parse(data).merge("cache_hit" => true) unless data.nil?
      lat, lon = location.coordinates
      uri = URI("#{BASE_URL}/weather")
      params = {
            lat: lat,
            lon: lon,
            appid: api_key,
          }.merge(options)
        begin
          response = connection.get(uri, params)
          if response.success?
            data = parse_weather(JSON.parse(response.body))
            RedisCacheService.store_cache_data(w_cache_key, data.to_json,CACHE_EXPIRATION_TIME)
            data.merge("cache_hit" =>  false)
          else
            raise response.body
          end
        rescue SocketError, Timeout::Error, StandardError => e
          raise e.wrapped_exception, "System failure, please check with your administrator: #{e}"
        end
    end

    private
    def api_key
      (ENV['OPEN_WEATHER_MAP_API_KEY'] || "6ad26ace0b28f1a5ddd8f2a25c305f1b")
    end

    def connection
      connection ||= Faraday.new do |conn|
        conn.request :retry, max: 2, retry_statuses: [401, 409]
      end
    end


    # parse weather data from response
    # returns current weather data
    def parse_weather(resp)
      {
        "current_temp" => resp.dig("main", "temp"),
        "min_temp" => resp.dig("main", "temp_min"),
        "max_temp" => resp.dig("main", "temp_max"),
        "feels_like" => resp.dig("main", "feels_like"),
        "humidity" => resp.dig("main", "humidity"),
        "wind_speed" => resp.dig("wind", "speed")
    }
    end
    
    #cache_key to store weather data in redis
    def cache_key(prefix, key)
      "weather/#{prefix}/#{key}"
    end
  end
end