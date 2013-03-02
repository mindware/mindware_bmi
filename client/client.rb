# The EM Module for 
module Client

	def post_init
		puts "Loading Client Connector..."
		puts "Switching from binary input..."
		send_data '{"enableRawOutput": true, "format": "Json"}'
	end

	def receive_data(data)
		puts data if data.include? "eSense"
	end
	
	def unbind
		puts "Disconnecting Client Connector..."
		EventMachine::stop_event_loop
	end
end
