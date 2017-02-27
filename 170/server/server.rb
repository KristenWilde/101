require "socket"

server = TCPServer.new("localhost", 3003)

def parse_request(request_line)
	request_line.match(/([A-Z]+) /)
	http_method = $1 || ""
	
	request_line.match(/ (\/.*)\?/)
	path = $1 || ""

	request_line.match(/\?(.*) /)
	params = $1.split("&").map {|pair| pair.split("=")}.to_h

	[http_method, path, params]
end


loop do 
	client = server.accept

	request_line = client.gets

	puts request_line

	next if !request_line || request_line =~ /favicon/
	
	http_method, path, params = parse_request(request_line)

	client.puts "HTTP/1.0 200 OK"
	client.puts "Content-Type: text/html"
	client.puts 
	client.puts "<html>"
	client.puts "<body>"
	client.puts "<pre>"
	client.puts http_method
	client.puts path
	client.puts params
	client.puts "</pre>"
	client.puts "<h1>Rolls!</h1>"

	params["rolls"].to_i.times do
	  roll = rand(params["sides"].to_i) + 1
	  client.puts "<p>", roll, "</p>"
	end

	client.puts "</body>"
	client.puts "</html>"
	client.close
end