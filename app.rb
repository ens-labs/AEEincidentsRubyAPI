require 'sinatra'
require_relative 'backend_api'

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
