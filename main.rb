require 'rubygems' if RUBY_VERSION < "1.9"
require 'bundler/setup'

$: << File.expand_path(File.dirname(__FILE__) + "/")

# Connector files
require 'client/connector'
require 'client/client'

# Server Files
require 'server/server'

# Load our Gemfile and require all needed gems
Bundler.require

class Mindware

	# Connector is the local Thinkgear Connector
	$CONNECTOR_ADDRESS = "127.0.0.1"
	$CONNECTOR_PORT	   = 13854
	
	$SERVER_ADDRESS = "0.0.0.0"
	$SERVER_PORT	= "8080"

	$SERVER_IP	= "127.0.0.1"
	#$SERVER_IP	= "192.168.1.x"

	def initialize
		grab_logo
		# Link to connector
		puts "Starting Multi-threading:"
		connector_thread = Thread.new {
			$connector = Connector.new($CONNECTOR_ADDRESS, $CONNECTOR_PORT)
		}
		
		websocket_thread = Thread.new {
			$ws	  = Server.new($SERVER_ADDRESS, $SERVER_PORT)	
		}	
		while true 
			sleep 1
		end
	end	

	def grab_logo
		File.open("etc/logo", "r") do |file|
 			 while line = file.gets
    				puts line
 			 end
		end
		puts "\nBy: Andres Colon Perez\n"+
		     "Github: http://github.com/mindware/mindware\n"
		puts "For: HackPR Mayaguez! March 2 2013"
		puts "\tShoutouts:\n"+
		     "\t----------\n"+
		     "\tGiancarlos Gonzalez (Government CIO)\n"+
		     "\tRoberto Rosario, Ramphis Castro, Oscar\n"+
		     "\tStartups of PR, TiG Team @ Rama Ejecutiva!\n"+
		     "\n"+
		     "\tSpecial thanks to the Hackathon Sponsors!\n"
		puts "\t-----------\n"
	end
end


Mindware.new
