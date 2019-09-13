require_relative 'war_socket_server'
require 'socket'

server = GoFishServer.new
server.start
server.run