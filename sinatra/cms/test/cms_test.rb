ENV["RACK_ENV"] = "test"

require 'minitest/autorun'
require 'rack/test'
require 'fileutils'

require_relative "../cms"

class CMSTest < Minitest::Test 
	include Rack::Test::Methods

  # required method tells rack/test what kind of app this is
	def app
		Sinatra::Application
	end

	def setup
		FileUtils.mkdir_p(data_path) # make a directory and all its parent directories, if they do not exist. Alias makedirs, mkpath
	end

	def teardown
		FileUtils.rm_rf(data_path) # remove recursively, force. Alias rmtree
		last_request.env["rack.session"].delete(:username)
	end

  # Helper methods for use in tests:

	def create_document(name, content="")
		File.open(File.join(data_path, name), "w") do |file|
			file.write(content)
		end
	end

	def session
		last_request.env["rack.session"]
	end

	def admin_session
    { "rack.session" => { username: "admin" } }
  end

	def test_index
		create_document "about.md"
		create_document "changes.txt"

		get "/"
	
		assert_equal 200, last_response.status
		assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
		assert_includes last_response.body, "about.md"
		assert_includes last_response.body, "changes.txt"
	end

	def test_view_document
		create_document "history.txt", "1993 - Yukihiro Matsumoto dreams up Ruby."

		get "/history.txt"
		
		assert_equal 200, last_response.status
		assert_equal "text/plain", last_response["Content-Type"]
		assert_includes last_response.body, "1993 - Yukihiro Matsumoto dreams up Ruby."
	end

	def test_error
    get "/badname" 
    assert_equal 302, last_response.status
		assert_equal "badname does not exist.", session[:message]
		
		get last_response["Location"]
		assert_nil session[:message]
	end

	def test_markdown
		create_document "about.md", "# Ruby is...\nA cool programming language"

		get "/about.md"

		assert_equal 200, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_includes last_response.body, "<h1>Ruby is...</h1>"
	end

	def test_edit_form
		create_document "changes.txt", "F C G7"

		get "/changes.txt/edit"
		assert_equal "You must be signed in to do that.", session[:message]

		get "/changes.txt/edit", {}, admin_session

    assert_equal 200, last_response.status
    assert_includes last_response.body, "<textarea"
    assert_includes last_response.body, "F C G7"
    assert_includes last_response.body, %q(<button type="submit")
  end

  def test_updating_document
  	create_document "changes.txt"
  	post "/changes.txt", {content: "new content"}, admin_session
  	
  	assert_equal 302, last_response.status
  	assert_equal "changes.txt has been updated.", session[:message]

  	get "/changes.txt"
  	assert_equal 200, last_response.status
  	assert_includes last_response.body, "new content"
  end

  def test_new_doc_form
  	get "/new"
		assert_equal "You must be signed in to do that.", session[:message]

		get "/new", {}, admin_session

  	assert_equal 200, last_response.status
  	assert_includes last_response.body, %q(<input type="text" name=")
  end

  def test_create_doc
  	post "/create", {newfile: "newdoc.md"}, admin_session

  	assert_equal 302, last_response.status
  	assert_equal "newdoc.md was created.", session[:message]
  	
  	get "/"
  	assert_includes last_response.body, "newdoc.md"
  end

  def test_create_new_doc_without_filename
  	post "/create", {newfile: ""}, admin_session

  	assert_equal 422, last_response.status
  	assert_includes last_response.body, "A name is required."
	end

	def test_delete
		create_document "temp.txt"
		post "/temp.txt/delete"
		assert_equal "You must be signed in to do that.", session[:message]

		post "/temp.txt/delete", {}, admin_session

		assert_equal 302, last_response.status
		assert_equal false, File.exist?(File.join(data_path, "temp.txt"))
		assert_equal "temp.txt was deleted.", session[:message]
	
		get "/"
		refute_includes last_response.body, %q(href="/temp.txt")
	end

	def test_signin_form
		get "/login"

		assert_equal 200, last_response.status
		assert_includes last_response.body, "<input"
		assert_includes last_response.body, %q(<button type="submit")
	end

	def test_signin
		post "/login", username: "admin", password: "secret"
		assert_equal 302, last_response.status
		assert_equal "Welcome!", session[:message]
		assert_equal "admin", session[:username]

		get last_response["Location"]
		assert_includes last_response.body, "Signed in as admin"
	end

	def test_signin_with_bad_credentials
		post "/login", username: "guest", password: "shhh"
		assert_equal 422, last_response.status
		assert_includes last_response.body, "Invalid Credentials"
		refute_equal "guest", session[:username]
	end

	def test_signout
		get "/", {}, admin_session
		assert_includes last_response.body, "Signed in as admin"

		post "/logout"
		assert_equal "You have been signed out.", session[:message]
		assert_nil session[:username]
	end
end
