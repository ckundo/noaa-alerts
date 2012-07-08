require "noaa-alerts/version"

module Noaa
  class Alert
    attr_reader :description, :locations, :identifier, :effective_at, :expires_at, :event, :urgency, :severity, :headline, :sent_at

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
      @sent_at = nil
      handle_entry(entry) if entry
    end

    private
    
    def handle_entry(entry)
      info = entry.fetch('info')
      @description = info.fetch('description')
      @event = info.fetch('event')
      @urgency= info.fetch('urgency')
      @severity = info.fetch('severity')
      @headline = info.fetch('headline')
      @locations = info.fetch('area').fetch('areaDesc').split('; ')
      @identifier = entry.fetch('identifier')
      @sent_at = Time.parse(entry.fetch('sent'))
      @effective_at = Time.parse(info.fetch('effective'))
      @expires_at = Time.parse(info.fetch('expires'))
    end
  end
end
