require 'rack'
require 'erb'
require 'sqlite3'
require 'sinatra'
require 'data_mapper'
require_relative 'album'
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/albums.sqlite3.db")
set :port, 8080
get "/" do
	redirect '/form'	
end
get "/form" do
	erb :form
end
post "/list" do
	@albums = Album.all(:order => [ params[:order].to_sym.asc ])
	@highlight = params[:rank].to_i
	erb :list
end
get "/list" do 
	@albums = Album.all(:order => [ :title.asc ])
	@highlight = 60
	erb :list
end