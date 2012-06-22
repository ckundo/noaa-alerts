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
Instantiate `Noaa::Client` with a two letter US state abbreviation. The result is an array of `Noaa::Alert` objects relevant attributes (`description`, `event`, `severity`, `locations`, etc).

    require 'noaa-alerts'
    noaa = Noaa::Client.new('ny')
    alert = noaa.alerts[0]

    puts alert.locations.join(', ')    # => 'Rockland, Westchester'
    puts alert.description             # => 'THE NATIONAL WEATHER SERVICE IN UPTON NY HAS ISSUED A\n* SEVERE THUNDERSTORM WARNING FOR...'
    puts alert.event                   # => 'Special Weather Statement'
    ...

## Requirements

Ruby 1.9

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
