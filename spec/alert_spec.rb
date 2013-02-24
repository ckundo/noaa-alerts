require 'spec_helper'

describe Noaa::Alert, :vcr do
  let(:response) do
    {
      'info' => 
      {
        'description' => '',
        'event' => 'foo',
        'urgency' => 'foo',
        'severity' => 'foo',
        'headline' => 'foo',
        'area' => {
          'areaDesc' => 'foo; bar'
        },
        'effective' => 'Sun, 24 Feb 2013 20:44:52 GMT',
        'expires' => 'Sun, 24 Feb 2013 20:44:52 GMT'
      },
      'identifier' => 'foo',
      'sent' => 'Sun, 24 Feb 2013 20:44:52 GMT'
    }
  end

  subject { Noaa::Alert.new('http://www.example.com', response) }

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
