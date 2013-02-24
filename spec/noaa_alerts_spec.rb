require 'spec_helper'

describe Noaa, :vcr do
  let(:location) { Noaa::Client.new("mn") }

  describe ".alerts" do
    context 'when there are no active NOAA alerts' do
      it 'has alerts' do
        location.alerts.should be_empty
      end
    end
  end
end
