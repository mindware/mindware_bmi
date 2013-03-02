# The EM Module for 
module Client

	def post_init
		puts "Loading Client Connector..."
		puts "Requesting switch from binary input..."
		# Request JSON output
		send_data '{"enableRawOutput": true, "format": "Json"}'
	end

	def receive_data(data)
		begin
			#puts data if data.include? "eSense"
			if data.include? "eSense"
				puts data
				#parsed = JSON.parse(data)
				parsed = process_protocol(data)
				if !parsed.empty?
					print "Attention: #{parsed[0][0]}" if !parsed[0][0].nil?	  #attention
					puts "\tMeditation: #{parsed[0][1]}" if !parsed[0][1].nil? #meditation
				end
			end
		rescue Exception => e
			puts "Data was not yet ready to be parsed. Continuing..."
		end
	end
	
	def unbind
		puts "Disconnecting Client Connector..."
		EventMachine::stop_event_loop
	end
	
	def process_protocol(data)
		data.scan(/"attention":(\d+)\,"meditation":(\d+)/)
	end
end
