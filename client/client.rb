# The EM Module for 
module Client

	def post_init
		puts "Loading Client Connector..."
		puts "Requesting switch from binary input..."
		# Request JSON output
		send_data '{"enableRawOutput": true, "format": "Json"}'
	end

	def receive_data(data)
		#puts data if data.include? "eSense"
		if data.include? "eSense"
			parsed = JSON.parse(data)
			print "Attention: #{parsed["attention"]}" if !parsed["attention"].nil?
			print "Meditation: #{parsed["meditation"}" if !parsed["meditation"].nil?
			puts ""
		end
	end
	
	def unbind
		puts "Disconnecting Client Connector..."
		EventMachine::stop_event_loop
	end
end
