require "alert"
require "httparty"

module Noaa
  class Client
    attr_reader :alerts

    def initialize(state)
      @alerts = []
      get_alerts(state)
    end

    private

    def get_alerts(state)
      catalog = HTTParty.get("http://alerts.weather.gov/cap/#{state}.php?x=0",
                             format: :xml)
      handle_catalog(catalog)
    end

    def handle_catalog(catalog)
      entries = catalog['feed']['entry']
      entries = [entries] unless entries.kind_of?(Array)
      entries.each do |entry| 
        item = HTTParty.get(entry['id'],
                            format: :xml)['alert']
        @alerts << Noaa::Alert.new(item)
      end
    end
  end
end
