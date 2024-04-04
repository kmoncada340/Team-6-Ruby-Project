require 'net/http'
require 'json'
require 'date'

def get_events_for_week(week_number)
  url = URI("https://api.example.com/events?week=#{week_number}")
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

# 使用示例：显示本周事件
events = get_events_for_week(1)
display_calendar(events)
