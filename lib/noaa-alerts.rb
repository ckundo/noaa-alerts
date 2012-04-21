require "noaa-alerts/version"
require "alert"
require "location"
require "httparty"

module Noaa
  module Alerts
    def self.find_by_state(state_abbr)
      messages = []
      alerts = []

      catalog = catalog_for_state(state_abbr)
      catalog.each do |entry|
        messages << message_from_catalog_entry(entry)
      end

      messages.each do |message|
        alerts << Alert.new(message)
      end

      return alerts
    end

    def self.catalog_for_state(state_abbr)
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
  end
end
