file = File.dirname(__FILE__) + '/../lib/locations.txt'
contents = File.open(file, 'r').read()
entries = contents.split("\n")
entries.each do |entry|
  fields = entry.split('|') # state, zone, cwa, name, state_zone, countyname, fips, timezone, fe_area, lat, lon
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
  Area.create(:state => fields[0], :zone => fields[1], :cws => fields[2], :name => fields[3],
              :state_zone => fields[4], :countyname => fields[5], :fips => fields[6], :timezone => tz,
              :fe_area => fields[8], :full_address => "#{fields[5]}, #{fields[0]}", 
              :latitude => fields[9], :longitude => fields[10])
end

