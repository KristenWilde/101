require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

before do
  @toc = File.readlines("data/toc.txt")
end

get "/" do
	@page_title = "The Adventures of Sherlock H"
	erb :home
end

get "/chapters/:number" do
	@num = params[:number]
	@chapter = File.read("data/chp#{@num}.txt")
	@chapter_title = @toc[@num.to_i - 1]
	@page_title = "Chapter #{@num}, #{@chapter_title}"
	erb :chapter
end

get "/show/:name" do
	params[:name]
end

helpers do
	def in_paragraphs(string)
		string.gsub("\n\n", "</p><p>")
	end
end

not_found do
	redirect "/"
end