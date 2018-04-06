require 'webrick'

RES_X, RES_Y = *`xdpyinfo`.scan(/(\d+)x(\d+) pixels/).flatten.map(&:to_i)
RATIO_X, RATIO_Y = 1000.0/RES_X, 1000.0/RES_Y

server = WEBrick::HTTPServer.new :Port => 8000

server.mount_proc '/' do |req, res|
  x, y = req.query["x"].to_i, req.query["y"].to_i
  x, y = (x * RATIO_X).to_i, (y * RATIO_Y).to_i
  `xdotool mousemove #{x} #{y}`
  res.body = 'ok'
end

trap 'INT' do server.shutdown end

server.start
