#start the server
#create rooms
#assign clients to room

require_relative '../lib/room'
require 'socket'

# server = WarSocketServer.new
# server.start
# server.run
class GoFishServer
  attr_reader :connected_clients, :rooms, :games, :pending_clients, :server

  def initialize
    @connected_clients = Hash.new
    @rooms = Hash.new
    @games = []
    @pending_clients = []
  end

  def port_number
    3336
  end
  
  def ip_address
    'localhost'
  end
  
  def start
    @server = TCPServer.new(ip_address, port_number)
  end
  
  def accept_new_client(player_name = "Player")
    client = server.accept_nonblock
    puts "Client connected"
    pending_clients.push(client)
  rescue IO::WaitReadable, Errno::EINTR
  end
  
  def stop
    rooms.each do |_game, connections|
      connections.each {|client| client.close}
    end
    @server.close if @server
  end
  
  def create_room
    
  end

  def add_clients_to_room

  end
end