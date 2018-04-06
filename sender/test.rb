require 'uri'
require 'net/http'

BASE = ARGV[0]

def send_location location
  x, y = *location.scan(/x:(\d+) y:(\d+)/).flatten

  Net::HTTP.get(URI("#{BASE}/mouse?x=#{x}&y=#{y}"))
end

old_location = ""

loop do
  sleep 0.1
  location = `xdotool getmouselocation`
  if location != old_location
    send_location(location)
    old_location = location
  end
end
