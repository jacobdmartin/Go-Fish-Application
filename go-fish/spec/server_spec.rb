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
    @client2 = MockWarSocketClient.new(@server.port_number)
    @pending_clients.push(@client2)
    @server.accept_new_client("Billy")
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


end