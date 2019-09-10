require_relative 'war_socket_server'
require 'socket'

server = WarSocketServer.new
server.start
server.run

# while true do
#   server.accept_new_client
#   game = server.create_game_if_possible
#   while game
#     server.run_game(game)
#   end
# end

# server.stop
