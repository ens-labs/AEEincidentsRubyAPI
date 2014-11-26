require 'sinatra'
require_relative 'backend_api'

set :public_folder, File.dirname(__FILE__) + '/public'

get '/' do
	send_file File.expand_path('index.html', settings.public_folder)
end

get '/api' do
	send_file File.expand_path('index.html', settings.public_folder)
end

get '/api/lista.json' do
	data = AEE_API.new()
	content_type :json
	data.get_lista
end

get '/api/pueblo_especifico.json' do
	pueblito = params[:pueblo]
	data = AEE_API.new()
	content_type :json
	data.pueblo_especifico(pueblito)
end

get '/api/all_averias.json' do
	data = AEE_API.new()
	content_type :json
	data.all_averias
end
