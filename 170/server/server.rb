require "socket"

server = TCPServer.new("localhost", 3003)
loop do 
	client = server.accept

	request_line = client.gets
	puts request_line

	# "GET /?rolls=2&sides=6 HTTP/1.1"
	request_line.match(/([A-Z]+) /)
	http_method = $1
	puts http_method

	request_line.match(/ (\/.*)\?/)
	path = $1
	puts path

	request_line.match(/\?(.*) /)
	params = $1.split("&").map {|pair| pair.split("=")}.to_h
	p params
	
	client.puts request_line
	
	params["rolls"].to_i.times { client.puts rand(params["sides"].to_i) + 1 }

	client.close
end