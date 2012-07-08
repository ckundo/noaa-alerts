require 'noaa-alerts'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
end

describe Noaa, :vcr do
  describe ".initialize" do
    it 'has alerts with non-empty values' do
      Noaa::Client.new("mn").alerts.should_not be_empty
      Noaa::Client.new("mn").alerts.each { |alert| alert.description.should_not be_empty }
    end

    describe Noaa::Alert do
      subject { Noaa::Client.new("mn").alerts.first }

      its(:url) { should_not be_empty }
      its(:event) { should_not be_empty }
      its(:urgency) { should_not be_empty }
      its(:severity) { should_not be_empty }
      its(:headline) { should_not be_empty }
      its(:locations) { should_not be_empty }
      its(:identifier) { should_not be_empty }
      its(:sent_at) { should be_an_instance_of Time }
      its(:effective_at) { should be_an_instance_of Time }
      its(:expires_at) { should be_an_instance_of Time }
    end
  end
end
