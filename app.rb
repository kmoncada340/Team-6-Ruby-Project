require 'sinatra'
require 'json'

#Define the API endpoints
get '/api/hello' do
    content_type :json
    {message: 'Hello World!'}.to_json
end

post '/api/greet' do
    content_type :json
    request_body = JSON.parse(request.body.read)
    name = request_body['name']
    {message: "Hello, #{name}!"}.to_json
end
