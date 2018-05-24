require "daily_reporter"
require "thor"
require 'togglv8'
require 'json'
require "dotenv"

module DailyReporter
  class CLI < Thor
    desc "create", "create a daily report"
    def create
      Dotenv.load

      # Set TogglV8::API
      toggl_api    = TogglV8::API.new(ENV["TOGGL_API_TOKEN"])
      user         = toggl_api.me(all=true)
      workspaces   = toggl_api.my_workspaces(user)
      workspace_id = workspaces.first['id']

      # Set TigglV8::ReportAPI
      reports = TogglV8::ReportsV2.new(api_token: ENV["TOGGL_API_TOKEN"])
      reports.workspace_id  = workspace_id

      # Fetch and Print
      today_str = (Time.now - 10000).strftime("%F")
      params = {since: today_str, until: today_str}
      summary = reports.summary('', params)
      result = summary[0]["items"].each_with_object({}) do |item, hash|
        title = item["title"]["time_entry"]
        hour, minute = milliseconds_to_hour_and_minute(item["time"])
        hash[title] = "#{hour}h #{minute}min"
        if hour.zero?
          puts "- #{title} (#{minute}min)" 
        else
          puts "- #{title} (#{hour}h#{minute}min)"
        end
      end
    end

    no_commands do
      def milliseconds_to_hour_and_minute(msec)
        minute = msec/1000/60
        return minute.div(60), minute.modulo(60)
      end
    end 
  end
end
