require 'spec_helper'
RSpec.describe Lightcast::Connection do
    subject { @connection }
  
    before do
      @connection = described_class.new(url: 'https://api.example.com', access_token: 'token')
    end
  
    describe '#get' do
      it 'issues a get request' do
        stub = stub_request(:get, 'https://api.example.com/path')
  
        @connection.get('/path')
  
        expect(stub).to have_been_requested
      end
    end
  end