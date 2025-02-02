# frozen_string_literal: true

require 'rails_helper'
describe WeatherForecastService do
  before(:each) do
    REDIS.with(&:flushdb)
  end

  it 'fetches the weather data for given lat and lon and cache hit must be false' do
    resp = {
      "coord": {
        "lon": -79.7083,
        "lat": 43.3955
      },
      "weather": [
        {
          "id": 801,
          "main": 'Clouds',
          "description": 'few clouds',
          "icon": '02d'
        }
      ],
      "base": 'stations',
      "main": {
        "temp": -0.63,
        "feels_like": -7.43,
        "temp_min": -1.01,
        "temp_max": 0.06,
        "pressure": 1045,
        "humidity": 59,
        "sea_level": 1045,
        "grnd_level": 1028
      },
      "visibility": 10_000,
      "wind": {
        "speed": 8.75,
        "deg": 80
      },
      "clouds": {
        "all": 14
      },
      "dt": 1_734_196_664,
      "sys": {
        "type": 1,
        "id": 547,
        "country": 'CA',
        "sunrise": 1_734_180_256,
        "sunset": 1_734_212_603
      },
      "timezone": -18_000,
      "id": 6_092_122,
      "name": 'Oakville',
      "cod": 200
    }
    stub_request(:get, "https://api.openweathermap.org/data/2.5/weather?lat=43.3955&lon=-79.7083&units=metric&appid=#{ENV['OPEN_WEATHER_MAP_API_KEY']}")
      .with(headers: {
              'Accept' => '*/*',
              'User-Agent' => 'Faraday v2.8.1'
            }).to_return(status: 200, body: resp.to_json, headers: {})
    location = OpenStruct.new(coordinates: [43.3955, -79.7083], postal_code: 'L6L 3K3', country_code: 'ca')
    response = WeatherForecastService.call(location, { 'units' => 'metric' })
    expect(response['current_temp']).to eq(-0.63)
    expect(response['min_temp']).to eq(-1.01)
    expect(response['cache_hit']).to eq false
    response = WeatherForecastService.call(location, { 'units' => 'metric' })
    expect(response['cache_hit']).to eq true
  end

  it 'throws error if api timeouts' do
    stub_request(:get, "https://api.openweathermap.org/data/2.5/weather?lat=43.3955&lon=-79.7083&units=metric&appid=#{ENV['OPEN_WEATHER_MAP_API_KEY']}").to_timeout
    location = OpenStruct.new(coordinates: [43.3955, -79.7083], postal_code: 'L6L 3K3', country_code: 'ca')
    expect { WeatherForecastService.call(location, { 'units' => 'metric' }) }.to raise_error(Timeout::Error)
  end
end
