module Documents
    module Actions
        module Course

            def course_get(id)
                @client.connection_services.post("/learn/api/public/v1/courses/{courseId}/meetings", **params)
            end

        end    
    end
end    
