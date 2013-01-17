require 'rack'

def getHeader
	return "<!DOCTYPE html><html><head><title>Rolling Stones Top 100</title></head><body><h1>Rolling Stone's Top 100 Albums</h1>"
end

def getFooter
	return "</body></html>"
end 

def getTop100(type, highlight)
	i = 1
	albums = []
	html = "<h2>Sorted by #{type.to_s}</h2>"
	File.readlines("top_100_albums.txt").each { |line|
		name, year = line.split(',')
		albums << { rank: i, name: name, year: year }
		i+=1
	}
	albums.sort! do |album1,album2| album1[type] <=> album2[type] end
	html += "<table>"
	albums.each { |album|
		style = album[:rank] == highlight ? "style='color: red;'" : ""
		html += "<tr #{style}><td>#{album[:rank]}</td><td>#{album[:name]}</td><td>#{album[:year]}</td></tr>"
	}
	html += "</table>"
	return html
end

def getStatic(type, highlight)
	html = getHeader
	html += getTop100(type,highlight)
	html += getFooter
	return html
end


class TOP
  @@root = File.expand_path(File.dirname(__FILE__))

  def call(env)
  	path = Rack::Utils.unescape(env['PATH_INFO'])
	query = Rack::Utils.parse_query(env['QUERY_STRING'], "&")
	if path == "/form"
		html = getStatic(:name,1)
	else
		html = getStatic(query["order"].to_sym, query["rank"].to_i)
	end
	[200, {"Content-Type" => "text/html"}, [html]]
  end
end

Rack::Handler::WEBrick.run TOP.new, :Port => 8080
