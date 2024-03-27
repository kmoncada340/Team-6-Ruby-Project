require 'oauth2'

#client_id = '4faebf99-af47-426d-b47c-58eb0d80878e'
#client_secret = 'gWgHHwBy5OIMK8cevlVYChx36Vh5T88n'
#client_key:`'a5f1f45e-ea54-4fae-a180-c4378a99588f`
#endpoint = 'https://api.blackboard.com/oauth2/token'

require 'rest-client'
require 'json'

class Authentication
  BASE_URL = 'https://developer.blackboard.com/learn/api/public/v1/oauth/authorizationcode'
  APPLICATION_ID = '4faebf99-af47-426d-b47c-58eb0d80878e'
  APPLICATION_KEY = 'a5f1f45e-ea54-4fae-a180-c4378a99588f'
  SECRET = 'gWgHHwBy5OIMK8cevlVYChx36Vh5T88n'

  def initialize
    @token = nil
  end


  def request_authorization_code
    headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    }

    #holds all the keys
    payload = {
      'client_id': APPLICATION_ID,
      'client_secret': SECRET,
      'grant_type': 'client_credentials'
    }

    begin
      response = RestClient.get(BASE_URL, params: payload, headers: headers)
      if response.code == 200
        data = JSON.parse(response.body)
        @token = data['access_token']
        puts "Authorization code received: #{@token}"
        #puts "This code worked?"
      else
        puts "Error: #{response.code}, #{response.body}"
      end
    rescue RestClient::ExceptionWithResponse => e
      puts "Error: #{e.response.code}, #{e.response.body}"
    end
  end
end