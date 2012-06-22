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
    subject { Noaa::Client.new("ak") }

    its(:alerts) { should_not be_empty }

    describe Noaa::Alert do
      subject { Noaa::Client.new("ak").alerts.first }

      its(:description) { should_not be_nil }
      its(:locations) { should_not be_empty }
    end
  end
end
