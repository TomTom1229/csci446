require 'rack'
require 'erb'
require 'sqlite3'

class AlbumsList
	include ERB::Util
	attr_accessor :albums
	def initialize(file, template, type, highlight)
		setupAlbums(file, type, highlight)
		@template = template
	end

	def setupAlbums(database, type, highlight)
		@albums = []
		database.execute("select * from albums").each { |row|
			@albums << { rank: row[0], name: row[1], year: row[2], highlight: highlight == row[0]}
		}
		albums.sort! do |album1, album2| album1[type] <=> album2[type] end
	end

	def render
		ERB.new(File.read(@template)).result(binding)
	end
end

def getList(type, highlight)
	db = SQLite3::Database.new("albums.sqlite3.db")
	list = AlbumsList.new(db, "list.html.erb", type, highlight)
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