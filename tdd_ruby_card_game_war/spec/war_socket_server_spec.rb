require 'socket'
require_relative '../lib/war_socket_server'

class MockWarSocketClient
  attr_reader :socket
  attr_reader :output

  def initialize(port)
    @socket = TCPSocket.new('localhost', port)
  end

  def provide_input(text)
    @socket.puts(text)
  end

  def capture_output(delay=0.1)
    sleep(delay)
    @output = @socket.read_nonblock(1000) # not gets which blocks
  rescue IO::WaitReadable
    @output = ""
  end

  def close
    @socket.close if @socket
  end
end

describe WarSocketServer do
  def create_two_clients
    @client1 = MockWarSocketClient.new(@server.port_number)
    @pending_clients.push(@client1)
    @server.accept_new_client("Player 1")
    @client2 = MockWarSocketClient.new(@server.port_number)
    @pending_clients.push(@client2)
    @server.accept_new_client("Player 2")
  end

  before(:each) do
    @pending_clients = []
    @server = WarSocketServer.new
  end

  after(:each) do
    @server.stop
    @pending_clients.each do |client|
      client.close
    end
  end

  it "is not listening on a port before it is started"  do
    expect {MockWarSocketClient.new(@server.port_number)}.to raise_error(Errno::ECONNREFUSED)
  end

  it "accepts new clients and starts a game if possible" do
    @server.start
    create_two_clients
    @server.create_game_if_possible
    expect(@server.connected_games.count).to eq 1
  end

  it 'allows multiple games on one server' do
    @server.start
    create_two_clients
    @server.create_game_if_possible
    create_two_clients
    @server.create_game_if_possible
    expect(@server.connected_games.count).to eq 2
  end

  it 'plays a round if both clients say "Play"' do
    @server.start
    create_two_clients
    game = @server.create_game_if_possible
    @client1.provide_input("Play")
    @client2.provide_input("Play")
    @server.run_game(game)
    expect(game.player1.players_hand).to_not eq(game.player2.players_hand)
  end

  it 'returns true if cards tie' do
    @server.start
    @card1 = PlayingCard.new("7", "Spades")
    @card2 = PlayingCard.new("7", "Hearts")
    expect(@card1.tie(@card2)).to eq true
  end

  it 'returns true if one card wins' do
    @server.start
    @card1 = PlayingCard.new("4", "Spades")
    @card2 = PlayingCard.new("7", "Hearts")
    expect(@card2.wins(@card1)).to eq true
  end

  # Add more tests to make sure the game is being played
  # For example:
  #   make sure the  client gets appropriate output
  #   make sure the next round isn't played until both clients say they are ready to play
  #   ...
end