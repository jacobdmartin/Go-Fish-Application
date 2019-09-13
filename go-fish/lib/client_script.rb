require 'socket'

s = TCPSocket.new 'localhost', 3336
s.puts "Game of War Created"

Thread.new do
  loop do
    puts s.gets
  end
end

loop do
  msg = $stdin.gets.chomp
  s.puts("Ready\n")
end

s.close