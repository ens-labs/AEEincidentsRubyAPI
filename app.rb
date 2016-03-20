require 'sinatra'
require 'sinatra/cross_origin'
require_relative 'backend_api'

configure do
  enable :cross_origin
end

API = AEE_API.new()

set :public_folder, File.dirname(__FILE__) + '/public'

get '/' do
	send_file File.expand_path('index.html', settings.public_folder)
end

get '/api' do
	send_file File.expand_path('index.html', settings.public_folder)
end

get '/api/' do
	send_file File.expand_path('index.html', settings.public_folder)
end

get '/api/lista.json' do
	content_type :json
	API.get_list
end

get '/api/pueblo_especifico.json' do
	content_type :json
	API.get_specific_town(params[:pueblo])
end

get '/api/all_averias.json' do
	content_type :json
	API.get_all_breakdowns
end
