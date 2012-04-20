require 'noaa-alerts'

describe Noaa::Alerts do
  let(:alerts) { Noaa::Alerts.find_by_state("us") }

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
      alert.areas.should be_an_instance_of Array
      alert.areas.should_not be_empty
    end

    xit 'has coordinates' do
      alert.latitude.should be_an_instance_of Float
      alert.longitude.should be_an_instance_of Float
    end
    
    xit 'has geographic bounds'
  end
end
