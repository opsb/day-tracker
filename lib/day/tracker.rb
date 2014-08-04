require "day/tracker/version"

module Day
  module Tracker
  	class Cli < Thor
  		FILE_PATH = File.expand_path("~/day-tracker")

  		def initialize(*args)
		  super
		  FileUtils.touch FILE_PATH
		end

  		desc "list", "list recorded days"
  		def list
  			puts File.read(FILE_PATH)
  		end

  		desc "add PROJECT_NAME", "add a project for today"
  		def add(project_name)
  			open(FILE_PATH, 'a') do |file|
  				file.puts Time.now.strftime("%B %d - #{project_name}")
  			end
  		end

  		default_task :list
  	end
  end
end
