module Noaa
  module Alerts
    class Alert
      attr_reader :description, :latitude, :longitude, :fips_codes, :locations,
        :fips_codes, :expires_at, :effective_at, :nws_id, :event_name, :summary, :category, :instructions, :severity, :certainty, :urgency

      def initialize(message)
        @fips_codes = []
        @description = message.fetch('info').fetch('description')
        @expires_at = DateTime.parse(message.fetch('info').fetch('expires'))
        @effective_at = DateTime.parse(message.fetch('info').fetch('effective'))
        @nws_id = message.fetch('identifier')
        @event_name = message.fetch('info').fetch('event')
        @summary = message.fetch('info').fetch('headline')
        @category = message.fetch('info').fetch('category')
        @instructions = message.fetch('info').fetch('instruction') || ""
        @severity = message.fetch('info').fetch('severity')
        @certainty = message.fetch('info').fetch('certainty')
        @urgency = message.fetch('info').fetch('urgency')

        @locations = parse_locations(message)
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
