# To run on c9: bundle exec ruby book_viewer.rb -p $PORT -o $IP

require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

# for matching a string to a chapter. This method no longer used.
# def search(string)
# 	results = []
# 	Dir.chdir("data") do 
# 		Dir.glob("chp*").each do |file|
# 			if File.read(file).match(string)
# 				chapter_num = file[3, 2].delete(".")
# 				chapter_title = @toc[chapter_num.to_i - 1]
# 			  results << [chapter_title, chapter_num]
# 			end
# 		end
# 	end
# 	results
# end

def each_chapter(&block)
  @toc.each_with_index do |name, index|
    number = index + 1
    contents = File.read("data/chp#{number}.txt")
    yield number, name, contents
  end
end

def each_paragraph_with_index(contents, &block)
	contents.split("\n\n").each_with_index { |paragraph, index| yield paragraph, index }
end

def search_paragraphs(string)
	results = []
	each_chapter do |number, name, contents|
		paragraph_hash = {}
		chapter_arr = [name, number, paragraph_hash]
		each_paragraph_with_index(contents) do |paragraph, index|
			if paragraph.include?(string)
				paragraph_hash[index.to_s] = paragraph
			end
		end
		results << chapter_arr unless paragraph_hash.empty?
	end
	results 
end

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
	@anchor_par = params[:paragraph]
	erb :chapter
end

get '/search' do
	@search_results = search_paragraphs(params[:query] || "") 

	erb :search
end

get "/show/:name" do
	params[:name]
end

helpers do
	def in_paragraphs(string)
		string.split("\n\n").map.with_index { |par, index| "<p id='#{index}'>#{par}</p>" }.join
	end
	
	def highlight(text, highlight_text)
		text.gsub(highlight_text, "<strong>#{highlight_text}</strong>")
	end
end

not_found do
	redirect "/"
end