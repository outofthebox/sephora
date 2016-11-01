class AdministracionController < ApplicationController
	def landings
    @landings = Landing.all
  end

  def events
  	@events = Event.all
  end

  def store_events
  	@store_events = StoreEvent.all
  end

  def photogram
    all_subscriptions = Instagram.subscriptions
    @subscriptions = []
    all_subscriptions.each do |s|
      @subscriptions << OpenStruct.new(s)
    end
  end

  def prices
  end

  def update_prices
    @file = Upload.find(params["file_id"])
    @prices = Producto.update_precios(@file.url, false)
    call_rake "producto:update_precios", {REMOTE: "TRUE", FILE: @file.url}
    flash[:notice] = "Updating Prices"
  end

  def files
    #raise S3_BUCKET.objects.with_prefix('folder_name').collect(&:key).inspect
    @uploads = Upload.all
  end

  def upload_file
    uploaded_file = params[:file]
    file = uploaded_file.read

    temp_file = Tempfile.new(params[:file].original_filename)
    temp_file.write(file)
    key_path = "productos/files/#{params[:file].original_filename}"

    #Make an object in your bucket for your upload
    obj = S3_BUCKET.objects[key_path]

    # Upload the file
    obj.write(:file => temp_file.path, :acl => :public_read)

    # Create an object for the upload
    @upload = Upload.new(
      url: obj.public_url.to_s,
      name: params[:file].original_filename
    )

    # Save the upload
    if @upload.save
      redirect_to admin_files_path, success: 'File successfully uploaded'
    else
      flash.now[:notice] = 'There was an error'
      redirect_to admin_files_path, success: 'File successfully uploaded'
    end
  end
end
