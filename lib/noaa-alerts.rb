require "noaa-alerts/version"
require "httparty"

module Noaa
  module Alerts
    def self.find_by_state(state_abbr)
      messages = []
      alerts = []

      catalog = message_catalog_for_state(state_abbr)
      catalog.each do |entry|
        messages << message_from_catalog_entry(entry)
      end

      messages.each do |message|
        alerts << Alert.new(message)
      end

      return alerts
    end

    def self.message_catalog_for_state(state_abbr)
      url = "http://alerts.weather.gov/cap/#{state_abbr}.php?x=0"
      response = HTTParty.get(url, :format => :xml).parsed_response
      entries = response.fetch("feed").fetch("entry")
      entries = [entries] unless entries.kind_of?(Array)
      return entries
    end

    def self.message_from_catalog_entry(entry)
      url = entry.fetch('id')
      response = HTTParty.get(url, :format => :xml).parsed_response
      response.fetch('alert')
    end

    class Alert
      attr_reader :description, :latitude, :longitude, :areas

      def initialize(message)
        @description = message.fetch('info').fetch('description')

        coords = extract_coordinates(message)
        @latitude = coords.fetch(:latitude)
        @longitude = coords.fetch(:longitude)

        @areas = message.fetch('info')
          .fetch('area')
          .fetch('areaDesc')
          .split(': ')
      end

      def extract_coordinates(message)
        latitude = 0.0
        longitude = 0.0 
        return { :latitude => latitude, :longitude => longitude }
      end
    end
  end
end
