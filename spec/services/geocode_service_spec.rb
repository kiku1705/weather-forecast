require "rails_helper"
describe GeocodeService do
  before(:all) do 
    Geocoder.configure(:lookup => :test)
  
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
     Geocoder::Lookup::Test.add_stub(
     "2380 Marine Dr, oakville, Ontario", [
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
    end

    it "successfully convert address to  lat, lon and postal_code" do
      address = '2380 Marine Dr, oakville, Ontario'
      location = GeocodeService.call(address)
      expect(location.coordinates).to eq [43.3954800,-79.7082528]
      expect(location.postal_code).to eq "L6L 3K3"
    end

    it "fails if address is incomplete" do
      address = "New York, NY, USA"
      expect { GeocodeService.call(address) }.to raise_error(IOError)
    end
end