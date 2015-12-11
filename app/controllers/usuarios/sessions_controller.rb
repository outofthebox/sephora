class Usuarios::SessionsController < Devise::SessionsController
	#layout :select_layout_type
  # def new
  #   super
  # end

  # def create
  #   super
  # end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    raise resource.inspect
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end
end
