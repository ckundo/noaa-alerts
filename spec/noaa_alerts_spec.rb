require 'noaa-alerts'
require 'vcr'

describe Noaa::Alerts do
  let(:alerts) { Noaa::Alerts.find_by_state("ak") }
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

  describe '.fetch_and_create' do
    it 'returns alerts' do
      alerts.should_not be_empty
    end
  end
RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
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

    it 'has other expected attributes' do
      alert.expires_at.should be_an_instance_of DateTime
      alert.effective_at.should be_an_instance_of DateTime
      alert.nws_id.should be_an_instance_of String
      alert.event_name.should be_an_instance_of String
      alert.summary.should be_an_instance_of String
      alert.category.should be_an_instance_of String
      alert.instructions.should be_an_instance_of String
      alert.severity.should be_an_instance_of String
      alert.certainty.should be_an_instance_of String
      alert.urgency.should be_an_instance_of String
      alert.fips_codes.should_not be_empty
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
