require 'webrick'

server = WEBrick::HTTPServer.new :Port => 8000

server.mount_proc '/' do |req, res|
  `xdotool mousemove #{req.query['x']} #{req.query['y']}`
  res.body = 'ok'
end

trap 'INT' do server.shutdown end

server.start
