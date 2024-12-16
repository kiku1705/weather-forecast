require "rails_helper"
describe ForecastsController, type: :controller do
    before(:all) do
      Geocoder.configure(:lookup => :test)
      Geocoder::Lookup::Test.add_stub(
     "2380 Marine Dr, Oakville, Ontario", [
        {
          'coordinates' => [43.3954800, -79.7082528],
          'address'      => '2380 Marine Dr, oakville, Ontario',
          'state'        => 'Ontario',
          'state_code'   => 'ON',
          'country'      => 'CANADA',
          'country_code' => 'CA',
          'postal_code' => 'L6L 3K3'
       }
    ])
    Geocoder::Lookup::Test.add_stub(
    "New York, NY, USA", [
      {
        'coordinates' => [40.7143528, -74.0059731],
        'address'      => 'New York, NY, USA',
        'state'        => 'New York',
        'state_code'   => 'NY',
        'country'      => 'United States',
        'country_code' => 'US'
      }
     ])
    
    resp = {
      "coord": {
        "lon": -79.7083,
        "lat": 43.3955
      },
      "weather": [
        {
          "id": 801,
          "main": "Clouds",
          "description": "few clouds",
          "icon": "02d"
        }
      ],
      "base": "stations",
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
      "visibility": 10000,
      "wind": {
        "speed": 8.75,
        "deg": 80
      },
      "clouds": {
        "all": 14
      },
      "dt": 1734196664,
      "sys": {
        "type": 1,
        "id": 547,
        "country": "CA",
        "sunrise": 1734180256,
        "sunset": 1734212603
      },
      "timezone": -18000,
      "id": 6092122,
      "name": "Oakville",
      "cod": 200
    }
    stub_request(:get, "https://api.openweathermap.org/data/2.5/weather?lat=43.39548&lon=-79.7082528&units=metric&appid=#{ENV['OPEN_WEATHER_MAP_API_KEY']}")
    .with(headers: {
      'Accept'=>'*/*',
      'User-Agent'=>'Faraday v2.8.1'
      }).to_return(status: 200, body: resp.to_json, headers: {})
    end

    describe "/forecasts/show" do
      it "shows weather forecast for the input address" do
        get :show, params: { "address" =>  '2380 Marine Dr, Oakville, Ontario' }
        expect(response.status).to eq(200)
        data = controller.view_assigns['weather_data'] 
        expect(data).not_to be_nil
      end

      it "should redirect to lookup if address is not complete" do
        get :show, params: { "address" =>  'New York, NY, USA' }
        expect(response.status).to eq(302)
      end
    end
end