require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "tilt/erubis"
require "redcarpet"
require "yaml"
require "bcrypt"

configure do
	enable :sessions
	set :session_secret, 'secret'
	set :erb, :escape_html => true
end

def data_path
	if ENV["RACK_ENV"] == "test"
		File.expand_path("../test/data", __FILE__)
	else
		File.expand_path("../data", __FILE__)
	end
end

def render_markdown(text)
	markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
	markdown.render(text)
end

def load_file_content(path)
	content = File.read(path)
	case File.extname(path)
	when ".md"
		erb render_markdown(content)
	when ".txt"
		headers["Content-Type"] = "text/plain"
		content
	end
end

def load_user_credentials
	credentials_path = if ENV["RACK_ENV"] == "test"
		File.expand_path("../test/users.yml", __FILE__)
	else
		File.expand_path("../users.yml", __FILE__)
	end
	YAML.load_file(credentials_path)
end

def valid_credentials?(username, password)
	users = load_user_credentials

	if users.key?(username)
		BCrypt::Password.new(users[username]) == password
	else
		false
	end
end

def block_unless_signed_in
	unless session.key?(:username)
		session[:message] = "You must be signed in to do that."
		redirect "/"
	end
end

get "/login" do
	erb :sign_in
end

post "/login" do
	if valid_credentials?(params[:username], params[:password])
		session[:username] = params[:username]
		session[:message] = "Welcome!"
		redirect "/"
	else
		session[:message] = "Invalid Credentials."
		status 422
		erb :sign_in
	end
end

post "/logout" do
	session.delete(:username) 
	session[:message] = "You have been signed out."
	redirect "/"
end

get "/" do
	pattern = File.join(data_path, "*")
  @filenames = Dir.glob(pattern).map do |path| 
  	File.basename(path)
  end
  erb :index
end

get "/new" do
	block_unless_signed_in
	erb :new
end

post "/create" do
	block_unless_signed_in
	if params[:newfile].empty?
		session[:message] = "A name is required."
		status 422
		erb :new
	else
		file_path = File.join(data_path, params[:newfile])
		File.new(file_path, "w+")
		session[:message] = "#{params[:newfile]} was created."
		redirect "/"
	end
end

get "/:filename" do
	filename = params[:filename]
	file_path = File.join(data_path, filename)
	if File.exist?(file_path)
		load_file_content(file_path)
	else
		session[:message] = "#{filename} does not exist."
		redirect "/"
	end
end

get "/:filename/edit" do
	block_unless_signed_in
	@filename = params[:filename]
	file_path = File.join(data_path, @filename)
  @content = File.read(file_path)
	erb :edit
end

post "/:filename" do
	block_unless_signed_in
	@filename = params[:filename]
	file_path = File.join(data_path, @filename)

	File.write(file_path, params[:content])
	
	session[:message] = "#{@filename} has been updated."
	redirect "/"
end

post "/:filename/delete" do
	block_unless_signed_in
	file_path = File.join(data_path, params[:filename])
	File.delete(file_path)
	
	session[:message] = "#{params[:filename]} was deleted."
	redirect "/"
end



