require 'faraday'

module Documents
  class Connection
    attr_accessor :access_token, :url

    def initialize(url:, access_token: nil, scope: 'classification_api')
      @access_token = access_token
      @url          = url
      @scope = scope
    end

    def get(path, **params)
      request(:get, path, params)
    end


    def request(method, path, params, options = {})
      response = connection.public_send(method, path, params) do |request|
        request.headers['accept'] = 'application/json'
        request.headers['Authorization'] = "Bearer #{@access_token}" if @access_token
      end

      raise Error.from_response(response) if (error = Error.from_response(response))

      response.body
    end

    private

    def connection
      @connection ||= Faraday.new(url: @url) do |c|
        c.request :json, content_type: /\bjson$/
        c.response :json, content_type: /\bjson$/
        c.adapter Faraday.default_adapter
      end
    end
  end
end
