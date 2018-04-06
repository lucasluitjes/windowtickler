require 'uri'
require 'net/http'

BASE = ARGV[0]

RES_X, RES_Y = *`xdpyinfo`.scan(/(\d+)x(\d+) pixels/).flatten.map(&:to_i)
RATIO_X, RATIO_Y = RES_X/1000.0, RES_Y/1000.0

def send_location location
  x, y = *location.scan(/x:(\d+) y:(\d+)/).flatten.map(&:to_i)
  x, y = (x * RATIO_X).to_i, (y * RATIO_Y).to_i

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
