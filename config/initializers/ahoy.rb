class Ahoy::Store < Ahoy::DatabaseStore
end

# set to true for JavaScript tracking
Ahoy.api = true

# Cookie-based visitor tracking
Ahoy.visitor_duration = 30.minutes
Ahoy.track_bots = false

# set to true for geocoding (and add the geocoder gem to your Gemfile)
Ahoy.geocode = false
