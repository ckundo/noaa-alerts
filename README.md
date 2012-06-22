# noaa-alerts

A library for consuming and formatting NOAA National Weather Service alerts.

## Installation

Add this line to your application's Gemfile:

    gem 'noaa-alerts'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install noaa-alerts

## Usage

    require 'noaa-alerts'
    noaa = Noaa::Client.new('ny')

    puts noaa.alerts[0].description             # => 'THE NATIONAL WEATHER SERVICE IN UPTON NY HAS ISSUED A\n* SEVERE THUNDERSTORM WARNING FOR...'
    puts noaa.alerts[0].locations.join(', ')    # => 'Rockland, Westchester'

## Requirements

Ruby 1.9

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
