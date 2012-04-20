require "noaa-alerts/version"
require "httparty"

module Noaa
  module Alerts
    def self.fetch_and_create(state_abbr)
      url = url_from_state(state_abbr)
      response = HTTParty.get(url, :format => :xml).parsed_response
      message = parse_message_from_response(response)
      return [Alert.new(message)]
    end

    def self.url_from_state(state_abbr)
      url = "http://alerts.weather.gov/cap/#{state_abbr}.php?x=0"
    end

    def self.parse_message_from_response(response)
      response.fetch('feed').fetch('entry')
    end

    class Alert
      attr_reader :summary, :latitude, :longitude

      def initialize(message)
        @summary = message.fetch('summary')
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
