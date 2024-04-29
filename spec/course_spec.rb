require 'spec_helper'

RSpec.describe Lightcast::Course do
    subject{ @course  }

    before do
        connection = instance_double("Lightcast::Connection")
        @course = described_class.new(connection: connection, course_id: '123')
    end 
    
    describe '#meetings' do
        it 'returns a list of course meetings' do
            allow(@course.connection).to receive(:get).and_return('meetings list')

            expect(@course.meetings).to eq('meetings list')
        end
    end
end