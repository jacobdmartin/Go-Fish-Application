#start the server
#create rooms
#assign clients to room

require_relative '../lib/room'
require 'socket'
require 'pry'

class GoFishSocketServer
  attr_reader :rooms, :clients_in_lobby, :server

  def initialize
    @rooms = Hash.new
    @clients_in_lobby = []
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
    clients_in_lobby.push(client)
    create_room_if_possible
  rescue IO::WaitReadable, Errno::EINTR
  end
  
  def stop
    rooms.each do |_game, connections|
      connections.each {|client| client.close}
    end
    @server.close if @server
  end

  def create_room_if_possible
    if clients_in_lobby.count == 3
      puts "Game of Go Fish created in a room with #{clients_in_lobby.count} players!"
      room = GoFishGame.new
      rooms[room] = clients_in_lobby.shift(3)
    end
  end
end