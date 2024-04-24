module Documents
    class Connection
        def initialize(url,auth_token)
            @connection = Faraday.new(url: url) do |builder|
                builder.request :json
                builder.headers[:accept] = "application/json"
                builder.response :json
                builder.request :authorization, auth_token, ""
            end
        end       
    
        def get(path, params = {})
            request(:get, path, params)
        end

        def post(path, params = {})
            request(:post, path, params)
        end

        def patch(path, params = {})
            request(:patch, path, params)
        end

        def delete(path, params = {})
            request(:delete, path, params)
        end
         
        
        def request(method, path, params = {}) 
            response = @connection.send(method, path, params)

            error = Error.from_response(response)
  
            raise error if error
  
            response.body
        end
    end
       

   


 
end
