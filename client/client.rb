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
			if data.include? "eSense"
				parsed = process_protocol(data)
				if !parsed.empty?
					attention = parsed[0][0]
					meditation= parsed[0][1]
					if(attention.to_i == 0 and meditation.to_i == 0)
						puts data
						puts "Waiting for Neural Input..."
					else
						print "Attention: #{attention}" if !attention.nil?	  #attention
						puts "\tMeditation: #{meditation}" if !meditation.nil? #meditation
						broadcast("[\"attention\":#{attention},\"meditation\":#{meditation}\"]") 
					end
				end
			end
		rescue Exception => e
			puts "Data was not yet ready to be parsed. Continuing...#{e.inspect}"
		end
	end
	
	def unbind
		puts "Disconnecting Client Connector..."
		EventMachine::stop_event_loop
	end
	
	def process_protocol(data)
		#parsed = JSON.parse(data) # Incoming data is invalid JSON, so we'll work on this later
		data.scan(/"attention":(\d+)\,"meditation":(\d+)/)	# Do it like a hacker. Regex!
	end

	def broadcast(data)
		if !$ws.nil?
			"#{self} sending data"
			$ws.broadcast(data)
		end
	end
end
