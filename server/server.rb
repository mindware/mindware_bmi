# Websocket Class
class Server

	# Create a Connector
	def initialize(host, port)
		@clients = []
		puts "Websocket Engine Starting up..."
		EM.run {
 			 EM::WebSocket.run(:host => host, :port => port) do |ws|
 			   ws.onopen { |handshake|
			      puts "\n\nIncoming WebSocket connection established!\n"
			      # Access properties on the EM::WebSocket::Handshake object, e.g.
 			      # path, query_string, origin, headers
			      # Publish message to the client
			      ws.send "Welcome to Mindware: you connected to #{handshake.path}"
			      @clients.push(ws)
			    }

			    ws.onclose { 
				puts "Connection closed"
				@clients.pop(ws)
			    }

 			    ws.onmessage { |msg|
 			     puts "Recieved message: #{msg}"
 			     ws.send "Pong: #{msg}"
			    }
 		 end
		}
	end

	def broadcast(data)
		puts "Websocket Server would broadcast data: #{data}"
		return false if @clients.nil?
		return false if @clients.length == 0
		@clients.each do |c|
			puts "Sending data to #{c}"
			c.send data
		end
	end

	# Stop the Websocket Server
	def stop	
	end
end
