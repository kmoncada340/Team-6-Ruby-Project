module Documents
    module Actions
        module Course

            def initialize(connection:, course_id:)
                @connection = connection
                @course_id = course_id
            end

            
            def meetings
                @connection.get("/learn/api/public/v1/courses/#{@course_id}/meetings")
              end  

        end    
    end
end    
