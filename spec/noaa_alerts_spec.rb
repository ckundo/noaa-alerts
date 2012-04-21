require 'noaa-alerts'

describe Noaa::Alerts do
  let(:alerts) { Noaa::Alerts.find_by_state("ak") }

  describe '.fetch_and_create' do
    it 'returns alerts' do
      alerts.should_not be_empty
    end
  end

  describe Noaa::Alerts::Alert do
    let(:alert) { alerts.first }
    
    it 'has a description' do
      alert.description.should be_an_instance_of String
      alert.description.length > 10
    end
    
    it 'has a list of affected areas' do 
      alert.locations.should be_an_instance_of Array
      alert.locations.should_not be_empty
    end

  end

  describe Noaa::Alerts::Location do
    let(:location) { Noaa::Alerts::Location.new("002068")}

    it 'has expected attributes' do
      location.latitude.should be_an_instance_of Float
      location.longitude.should be_an_instance_of Float
      location.county.should be_an_instance_of String
      location.time_zone.should be_an_instance_of String
    end
  end
end
