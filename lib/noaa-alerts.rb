require "noaa-alerts/version"
require "httparty"

module Noaa
  module Alerts
    def self.fetch_and_create(state_abbr)
      messages = []
      alerts = []
      entries = fetch_entries(state_abbr)

      entries.each do |entry|
        messages << fetch_alert_from_entry(entry)
      end

      messages.each do |message|
        alerts << Alert.new(message)
      end
      return alerts
    end

    def self.fetch_entries(state_abbr)
      url = "http://alerts.weather.gov/cap/#{state_abbr}.php?x=0"
      response = HTTParty.get(url, :format => :xml).parsed_response
      entries = response.fetch("feed").fetch("entry")
      entries = [entries] unless entries.kind_of?(Array)
      return entries
    end

    def self.fetch_alert_from_entry(entry)
      url = entry.fetch('id')
      response = HTTParty.get(url, :format => :xml).parsed_response
      response.fetch('alert')
    end

    class Alert
      attr_reader :description, :latitude, :longitude

      def initialize(message)
        @description = message.fetch('info').fetch('description')
        coords = extract_location(message)
        @latitude = coords.fetch(:latitude)
        @longitude = coords.fetch(:longitude)
      end

      def extract_location(message)
        longitude = 0.0
        latitude = 0.0
        return { :latitude => latitude, :longitude => longitude }
      end
    end
  end
end
