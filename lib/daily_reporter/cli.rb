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

      toggl_api    = TogglV8::API.new(ENV["TOGGL_API_TOKEN"])
      user         = toggl_api.me(all=true)
      workspaces   = toggl_api.my_workspaces(user)
      workspace_id = workspaces.first['id']

      reports = TogglV8::ReportsV2.new(api_token: ENV["TOGGL_API_TOKEN"])
      begin
        reports.summary
      rescue Exception => e
        puts e.message      # workspace_id is required
      end
      reports.workspace_id  = workspace_id
      summary               = reports.summary
      puts "Generating summary JSON..."
      puts JSON.pretty_generate(summary)
    end
  end
end
