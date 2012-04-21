module Noaa
  module Alerts
    class Alert
      attr_reader :description, :latitude, :longitude, :fips_codes, :locations,
        :fips_areas

      def initialize(message)
        @description = message.fetch('info').fetch('description')
        @locations = parse_locations(message)
        @fips_areas = []
      end

      def parse_locations(message)
        locations = []

        @fips_codes = message.fetch('info')
          .fetch('area')
          .fetch('geocode')
          .map { |g| g.fetch('value') if g.fetch('valueName') == 'FIPS6' }
          .compact!

        @fips_codes.each do |f|
          locations << Location.new(f)
        end

        return locations
      end

    end
  end
end
