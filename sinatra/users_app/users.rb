# bundle exec ruby users.rb -p $PORT -o $IP

require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'
require 'yaml'

before do
  @users = YAML.load_file("users.yaml")
end

get "/" do
  erb :home
end

get "/user/:user" do
  @user = params[:user]
  erb :user_page
end

helpers do
  def count_interests 
    sum = 0
    @users.each do |user, info|
      sum += info[:interests].size
    end
    sum
  end
end
