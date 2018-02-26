ENV["RACK_ENV"] = "test" # setting this environment variable so that we're ready to run tests, not start a web server.

require 'minitest/autorun'
require 'rack/test'

require_relative "app"

class AppTest < Minitest::Test
	include Rack::Test::Methods

	def app # expected by Rack test methods
		Sinatra::Application
	end

	def test_index
		get "/"
		assert_equal 200, last_response.status
		assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
		assert_equal "Hello world", last_response.body
	end


end