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

  def update_prices
    #raise S3_BUCKET.objects.with_prefix('folder_name').collect(&:key).inspect
    @uploads = Upload.all
  end

  def upload_file
    #Make an object in your bucket for your upload
    obj = S3_BUCKET.objects[params[:file].original_filename]

    # Upload the file
    obj.write(
      file: params[:file].tempfile,
      acl: :public_read
    )

    # Create an object for the upload
    @upload = Upload.new(
            url: obj.public_url,
            name: obj.key
        )

    # Save the upload
    if @upload.save
      redirect_to admin_update_prices_path, success: 'File successfully uploaded'
    else
      flash.now[:notice] = 'There was an error'
      redirect_to admin_update_prices_path, success: 'File successfully uploaded'
    end
  end
end
