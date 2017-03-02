require "socket"

server = TCPServer.new("localhost", 3003)

def parse_request(request_line)
	request_line.match(/([A-Z]+) /)
	http_method = $1 || ""
	
	request_line.match(/ (\/.*)\?/)
	path = $1 || ""

	request_line.match(/\?(.*) /)
	params = ($1 || "").split("&").map {|pair| pair.split("=")}.to_h

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
	
	client.puts "<h1>Counter</h1>"

	number = params["number"]
	client.puts "<p>The current number is #{number}.</p>"

	client.puts "<a href='?number=#{number.to_i + 1}'>Add one</a>"
	client.puts "<a href='?number=#{number.to_i - 1}'>Subtract one</a>"

	client.puts "</body>"
	client.puts "</html>"
	client.close
end