require 'rack'
require 'erb'

class AlbumsList
	include ERB::Util
	attr_accessor :albums
	def initialize(file, template, type, highlight)
		setupAlbums(file, type, highlight)
		@template = template
	end

	def setupAlbums(file, type, highlight)
		@albums = []
		i = 1
		File.readlines("top_100_albums.txt").each { |line|
			name, year = line.split(',')
			@albums << { rank: i, name: name, year: year.to_i, highlight: highlight == i}
			i+=1
		}
		albums.sort! do |album1, album2| album1[type] <=> album2[type] end
	end

	def render
		ERB.new(File.read(@template)).result(binding)
	end
end

def getList(type, highlight)
	list = AlbumsList.new("top_100_albums.txt", "list.html.erb", type, highlight)
	response = Rack::Response.new(list.render)
	response.finish
end

def getFormPage
	response = Rack::Response.new(ERB.new(File.read("form.html.erb")).result)
	response.finish
end

class TOP

  def call(env)
  	request = Rack::Request.new(env)
  	query = Rack::Utils.parse_query(env['QUERY_STRING'], "&")
  	case request.path
  	when "/form" then getFormPage
	when "/list" then getList(:name,1)
	when "/"
		if query["order"] 
			getList(query["order"].to_sym, query["rank"].to_i)
		else
			getFormPage
		end 
	else
		getFormPage
	end
  end
end

Rack::Handler::WEBrick.run TOP.new, :Port => 8080