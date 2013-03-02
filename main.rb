require 'rubygems' if RUBY_VERSION < "1.9"
require 'bundler/setup'

$: << File.expand_path(File.dirname(__FILE__) + "/")

# Connector files
require 'client/connector'
require 'client/client'

# Server Files


# Load our Gemfile and require all needed gems
Bundler.require

class Mindware

	# Connector is the local Thinkgear Connector
	$CONNECTOR_ADDRESS = "127.0.0.1"
	$CONNECTOR_PORT	   = 13854
	
	$SERVER_ADDRESS = "0.0.0.0"
	$SERVER_PORT	= "8080"

	def initialize
		# Link to connector
		connector = Connector.new($CONNECTOR_ADDRESS, $CONNECTOR_PORT)
	end	
end


Mindware.new
