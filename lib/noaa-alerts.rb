require "noaa-alerts/version"
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

    class Alert
      attr_reader :description, :latitude, :longitude, :fips_codes, :locations
      @message = ""

      def initialize(message)
        @message = message
        @description = @message.fetch('info').fetch('description')
        @locations = parse_locations()
      end

      def parse_locations
        locations = []
        all_locations = read_locations_from_file()

        fips_codes = @message.fetch('info')
          .fetch('area')
          .fetch('geocode')
          .map { |g| g.fetch('value') if g.fetch('valueName') == 'FIPS6' }
          .compact!

        fips_codes.each do |f|
          locations << all_locations.collect {|l| l if l[:fips_code] == f }
        end

        return locations.flatten.compact
      end

      def read_locations_from_file
        locations = []

        file = File.dirname(__FILE__) + '/locations.txt'
        contents = File.open(file, 'r').read()
        entries = contents.split("\n")
        entries.each do |entry|
          fields = entry.split('|')
          case fields[7]
          when "A"
            tz = "Alaska"
          when "H"
            tz = "Hawaii"    
          when "m"
            tz = "Arizona"    
          when "M"
            tz = "Mountain Time (US & Canada)"
          when "C"
            tz = "Central Time (US & Canada)"
          when "E"
            tz = "Eastern Time (US & Canada)"
          when "P"
            tz = "Pacific Time (US & Canada)"
          else
            tz = ""
          end
          locations << {
            :state => fields[0],
            :name => fields[3],
            :state_zone => fields[4],
            :county => fields[5],
            :fips_code => "0" + fields[6],
            :time_zone => tz,
            :latitude => fields[9].to_f,
            :longitude => fields[10].chomp!.to_f
          }
        end

        return locations
      end
    end
  end
end
