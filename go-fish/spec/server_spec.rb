require 'pry'
class MockGoFishSocketClient
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

describe 'GoFishServer' do

  def create_two_clients 
    @client1 = MockGoFishSocketClient.new(@server.port_number)
    @pending_clients.push(@client1)
    @server.accept_new_client("Betty")
    @client2 = MockGoFishSocketClient.new(@server.port_number)
    @pending_clients.push(@client2)
    @server.accept_new_client("Billy")
  end

  def create_three_clients 
    @client1 = MockGoFishSocketClient.new(@server.port_number)
    @pending_clients.push(@client1)
    @server.accept_new_client("Betty")
    @client2 = MockGoFishSocketClient.new(@server.port_number)
    @pending_clients.push(@client2)
    @server.accept_new_client("Billy")
    @client3 = MockGoFishSocketClient.new(@server.port_number)
    @pending_clients.push(@client3)
    @server.accept_new_client("Bobby")
  end

  before(:each) do
    @pending_clients = []
    @server = GoFishSocketServer.new
  end

  after(:each) do
    @server.stop
    @pending_clients.each do |client|
      client.close
    end
  end

  it "is not listening on a port before it is started"  do
    expect {MockGoFishSocketClient.new(@server.port_number)}.to raise_error(Errno::ECONNREFUSED)
  end

  describe '#accept_new_client' do
    it "accepts 2 new clients" do
      @server.start
      create_two_clients
      expect(@server.clients_in_lobby.count).to eq 2
      expect(@server.rooms.count).to eq 0
    end
  end

  describe '#create_room_if_possible' do
    it 'expects a room to be created and a game running when clients_in_lobby equals 3' do
      @server.start
      create_three_clients
      expect(@server.rooms.count).to eq 1
      expect(@server.clients_in_lobby.count).to eq 0
    end
  end
  
    it 'allows multiple rooms on one server' do
      @server.start
      create_three_clients
      create_three_clients
      expect(@server.rooms.length).to eq 2
    end
end