# this class initiates the client to the connector
class Connector

	# Create a Connector
	def initialize(host, port)
		puts "Initializing Connector..."
		# Start the connector	
		EventMachine::run do 
			EventMachine::connect host, port, Client
		end
	end

	# Stop the ThinkGear Connector
	def stop	
	end
end
