namespace :usuarios do
  task :obtener_usuarios => :environment do
    #AWS S3 SETUP
    bucket_name = "sephoramexico"
    temp_file = Tempfile.new("todos_#{Date.today.to_s}")
    key_path = "usuarios/"+File.basename(temp_file)+".csv"
    s3 = AWS::S3.new

    @usuarios = Usuario.order("created_at DESC");

    CSV.open(temp_file, "w") do |csv|  
      csv << Usuario.attribute_names
      @usuarios.each do |u|
        csv << u.attributes.values
      end
    end

    s3.buckets[bucket_name].objects[key_path].write(:file => temp_file.path, :acl => :public_read)
    url_for_read = s3.buckets[bucket_name].objects[key_path].url_for(:read) rescue "/"

    puts "Uploading file #{temp_file.path} to bucket #{bucket_name}."
    puts "Download from: #{url_for_read}"
  end
end