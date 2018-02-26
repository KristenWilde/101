require 'erb'
require_relative 'advice'

class App < MyFramework
	def call(env)
		case env['REQUEST_PATH']
		when '/'
			['200', {'Content-Type' => 'text/html'}, [erb(:index)]]
		when '/advice'
			piece_of_advice = Advice.new.generate
			status = '200'
			headers = {'Content-Type' => 'text/html'}
			response(status, headers) do
				erb(:advice, message: piece_of_advice)
			end
		else 
			status = '404'
			headers= {"Content-Type" => 'text/html', "Content-Length" => '62'}
			response(status, headers) do 
				erb(:not_found)
			end
		end
	end
end