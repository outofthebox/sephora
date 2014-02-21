desc "This task is called by the Heroku scheduler add-on"
task :reindex_products => :environment do
  puts "Updating Products..."
	task :cron => 'fs:index'
  puts "done."
end