require "noaa-alerts/version"

module Noaa
  class Alert
    attr_reader :description, :locations, :identifier, :effective_at, :expires_at, :event, :urgency, :severity, :headline

    def initialize(entry)
      @description = ""
      @event = ""
      @urgency = ""
      @severity = ""
      @headline = ""
      @locations = []
      @identifier = ""
      @effective_at = nil
      @expires_at = nil
      handle_entry(entry)
    end

    private
    
    def handle_entry(entry)
      @description = entry['info']['description']
      @event = entry['info']['event']
      @urgency= entry['info']['urgency']
      @severity = entry['info']['severity']
      @headline = entry['info']['headline']
      @locations = entry['info']['area']['areaDesc'].split('; ')
      @identifier = entry['identifier']
      @effective_at = Time.parse(entry['info']['effective'])
      @expires_at = Time.parse(entry['info']['expires'])
    end
  end
end
