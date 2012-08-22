class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    current_usuario
  end

  rescue_from Exception do |exception|
    render :file => "error/404", :status => 404
  end if Rails.env.production?
end
