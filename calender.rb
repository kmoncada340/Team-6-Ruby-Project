require 'net/http'
require 'json'
require 'date'

def get_events_for_week(week_number)
  base_url = 'https://developer.blackboard.com/portal/displayApi'
  endpoint = '/calendar/events'
  url = URI("#{base_url}#{endpoint}?week=#{week_number}")
  
  response = Net::HTTP.get(url)

  if response.code == "200"
    events = JSON.parse(response.body)
    return events
  else
    puts "Error: #{response.code} - #{response.message}"
    return []
  end
end

def display_calendar(events)
  week_dates = (Date.today..Date.today + 6).to_a
  week_dates.each do |date|
    puts "Date: #{date}"
    daily_events = events.select { |event| Date.parse(event['date']) == date }
    if daily_events.empty?
      puts "No events"
    else
      daily_events.each do |event|
        puts "- #{event['description']}"
      end
    end
    puts ""
  end
end

# 示例数据：假设这是从API获取到的一周内的事件
events = [
  { 'date' => '2024-05-01', 'description' => 'Meeting with team' },
  { 'date' => '2024-05-02', 'description' => 'Project deadline' },
  { 'date' => '2024-05-04', 'description' => 'Lunch with client' }
]

# 显示日历
display_calendar(events)
