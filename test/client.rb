require 'eventmachine'
require 'em-websocket'
require 'em-websocket-client'
$SERVER_IP = "127.0.0.1" if $SERVER_IP.nil?
EM.run do
  conn = EventMachine::WebSocketClient.connect("ws://#{$SERVER_IP}/")

  conn.callback do
    conn.send_msg "Hello!"
    conn.send_msg "done"
  end

  conn.errback do |e|
    puts "Got error: #{e}"
  end

  conn.stream do |msg|
    puts "<#{msg}>"
    if msg.data == "done"
      conn.close_connection
    end
  end

  conn.disconnect do
    puts "gone"
    EM::stop_event_loop
  end
end

# prints out:
# <Hello!>
# <done>
# gone
