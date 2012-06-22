require "noaa-alerts/version"

module Noaa
  class Alert
    attr_reader :description, :locations

    def initialize(entry)
      @description = ""
      @locations = []
      handle_entry(entry)
    end

    private
    
    def handle_entry(entry)
      @description = entry['info']['description']
      @locations = entry['info']['area']['areaDesc'].split('; ')
    end
  end
end
