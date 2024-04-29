require 'spec_helper'

RSpec.describe Lightcast::Course do
    subject{ @course  }

    before do
        connection = instance_double("Lightcast::Connection")
        @course = described_class.new(connection: connection, course_id: '123')
    end 
    
    describe '#meetings' do
        it 'returns a list of course meetings' do
            expected_response = {
              "results": [
                {
                  "id": 0,
                  "courseId": "123ABC",
                  "title": "My Course Meeting",
                  "description": "A description of the meeting",
                  "start": "2024-04-29T23:05:15.674Z",
                  "end": "2024-04-29T23:05:15.674Z",
                  "externalLink": "www.zoom.com/meeting/123ABC"
                }
              ],
              "paging": {
                "nextPage": "https://api.blackboard.com/page/next"
              }
            }.to_json

            allow(@course.connection).to receive(:get).and_return(expected_response)

            expect(@course.meetings).to eq(expected_response)
        end
    end
end