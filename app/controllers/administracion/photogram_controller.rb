class Administracion::PhotogramController < AdministracionController
  skip_before_filter :verify_authenticity_token

  def new
    @photogram =  OpenStruct.new({
      client_id: "",
      client_secret: "",
      object: "",
      aspect: "",
      callback_url: ""
    })
  end

  def create
    sub_params = {
      object: params[:object],
      object_id: params[:object_id],
      aspect: params[:aspect],
      callback_url: params[:callback_url],
    }
    Instagram.create_subscription(sub_params)
    redirect_to admin_photogram_path("")
  end

  def update
  end

  def show
    redirect_to admin_photogram_path("") and return
  end

  def suscribe
    text = params['hub.challenge']
    render :text => text
  end

  def fetch
    Instagram.process_subscription(request.body.read) do |handler|
      handler.on_tag_changed do |tag, data|
        Instagram.tag_recent_media(tag).each do |data|
          MediaTag.parse data
        end
      end
    end
    render :text => ""
  end

  def destroy
    Instagram.delete_subscription(params[:id])
    redirect_to admin_photogram_path("") and return
  end
end