module Noaa
  module Alerts
    class Location
      attr_reader :latitude, :longitude, :state, :county, :fips_code, :time_zone

      def initialize(fips_code)
        all_locations = []
        locations_file = File.open(
          File.dirname(__FILE__) + '/locations.txt', 'r')
          .read()

        entries = locations_file.split("\n")
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
            all_locations << {
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

        fips_code_to_location(fips_code, all_locations)
      end

      def fips_code_to_location(fips_code, all_locations)
        all_locations.each do |l|
          if l[:fips_code] == fips_code
            @latitude = l[:latitude]
            @longitude = l[:longitude]
            @state = l[:state]
            @county = l[:county]
            @fips_code = l[:fips_code]
            @time_zone = l[:time_zone]
          end
        end
      end

    end
  end
end
