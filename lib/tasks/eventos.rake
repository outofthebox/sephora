require 'rake'

namespace :eventos do
  task :populate => :environment do
		require 'remote_file'
    require 'csv'


    raise "Necesario especificar ruta a FILE.csv" unless ENV['FILE']

    file = ENV['FILE'];
    data = []

    if ENV["REMOTE"]
    	rm = RemoteFile.new(file)
      csv = CSV.parse(rm.request.body, :headers => true)
    else
      csv_text = File.read(file)
      csv = CSV.parse(csv_text, :headers => true)
    end

    csv.each do |row|
      title = row[0];
      description = row[1]
      Event.create({:title => title, :description => description})
    end
  end

  task :add_dates => :environment do
		require 'remote_file'
    require 'csv'


    raise "Necesario especificar ruta a FILE.csv" unless ENV['FILE']

    file = ENV['FILE'];
    data = []

    if ENV["REMOTE"]
    	rm = RemoteFile.new(file)
      csv = CSV.parse(rm.request.body, :headers => true)
    else
      csv_text = File.read(file)
      csv = CSV.parse(csv_text, :headers => true)
    end

    csv.each do |row|
      store_id = row[0]
      event_name = row[1]
      dates = row[2]
      link = row[3]

      store = Tienda.find(store_id) rescue nil
      if store
      	event = Event.find_by_title(event_name)
      	StoreEvent.create({:tienda_id => store.id, :event_id => event.id, :dates => dates, :link => link})
      end
    end
  end

  task :prune_all => :environment do
  	Event.destroy_all
  end
end