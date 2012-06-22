require "noaa-alerts/version"

module Noaa
  class Alert
    attr_reader :description, :locations, :identifier, :effective_at, :expires_at

    def initialize(entry)
      @description = ""
      @locations = []
      @identifier = ""
      @effective_at = nil
      @expires_at = nil
      handle_entry(entry)
    end

    private
    
    def handle_entry(entry)
      @description = entry['info']['description']
      @locations = entry['info']['area']['areaDesc'].split('; ')
      @identifier = entry['identifier']
      @effective_at = Time.parse(entry['info']['effective'])
      @expires_at = Time.parse(entry['info']['expires'])
    end
  end
end
