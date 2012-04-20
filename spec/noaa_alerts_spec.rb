require 'noaa-alerts'

describe Noaa::Alerts do
  let(:alerts) { Noaa::Alerts.fetch_and_create("ny") }

  describe '.fetch_and_create' do
    it 'returns alerts' do
      alerts.should_not be_empty
    end
  end

  describe Noaa::Alerts::Alert do
    let(:alert) { alerts.first }
    
    it 'has a description' do
      alert.description.should_not be_empty
    end
    
    it 'has coordinates' do
      alert.latitude.should_not be_nil
      alert.longitude.should_not be_nil
    end
  end
end
