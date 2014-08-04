require "day/tracker/version"

module Day
  module Tracker
  	class Cli < Thor
  		FILE_PATH = File.expand_path("~/.day-tracker")

  		def initialize(*args)
		  super
		  FileUtils.touch FILE_PATH
		end

  		desc "list", "list recorded days"
  		def list
  			puts File.read(FILE_PATH)
  		end

  		desc "add PROJECT_NAME [FRACTION]", "add a project for today"
  		def add(project, fraction=1)
  			entry = format_entry(project, fraction)
  			return if entry_exists?(entry)

  			open(FILE_PATH, 'a') do |file|
  				file.puts entry
  			end

  			list
  		end

  		no_commands do
	  		def entry_exists?(entry)
	  			File.readlines(FILE_PATH).grep(entry).any?
	  		end

	  		def format_entry(project, fraction)
	  			Time.now.strftime("%B %d - #{project} - #{formatted_fraction(fraction)}")
	  		end

	  		def formatted_fraction(fraction)
	  			{
  					"0.5" => "half",
  					".5" => "half",
  					"1" => "full"	  				
	  			}[fraction]	  			
	  		end
	  	end

  		default_task :list
  	end
  end
end
