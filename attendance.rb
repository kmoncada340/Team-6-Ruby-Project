require 'sinatra'
require 'json'

# Simulated permission verification method.模拟检查用户是否有查看课程会议的权限。
def has_view_entitlement?(entitlement)
    entitlement == "course.attendance.VIEW"
end

# Simulated data acquisition method.模拟从数据源获取会议信息

def fetch_meetings(course_id, offset, limit, sort, fields)

# Because there is no data in the database, the following is sample data

[
    {
      id: 1,
      courseId: course_id,
      title: "Introductory Session",
      description: "Welcome to the course!",
      start: "2024-03-28T10:00:00Z",
      end: "2024-03-28T1:00:00Z",
      externalLink: "http://example.com/meeting/1"
    }
  ].select { |meeting| fields.include?('all') || meeting.keys.any? { |k| fields.include?(k.to_s) } }
end

get '/learn/api/public/v1/courses/:courseId/meetings' do
  content_type :json

  unless has_view_entitlement?
    status 403
    return { error: 'Forbidden', message: 'You do not have access to view course meetings.' }.to_json
  end

  course_id = params['courseId']
  offset = params.fetch('offset', 0).to_i
  limit = params.fetch('limit', 10).to_i
  sort = params.fetch('sort', 'start')
  fields = params.fetch('fields', 'all').split(',')

  meetings = fetch_meetings(course_id, offset, limit, sort, fields)

  { results: meetings, paging: { nextPage: "Here you should implement the logic for pagination" } }.to_json
end


#GET请求处理器读取路径参数 :courseId 和查询参数 offset、limit、sort、fields，然后根据这些参数获取并返回会议信息。
#权限验证和数据获取逻辑在这个示例中被大大简化了。在真实场景中，你需要实现真正的权限验证逻辑，并从实际的数据存储（如数据库）中查询数据。
#http://localhost:4567