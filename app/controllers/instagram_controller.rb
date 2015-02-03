class InstagramController < ApplicationController
  http_basic_authenticate_with :name => ENV['U'], :password => ENV['P'], only: :admin
  skip_before_filter :verify_authenticity_token

  def admin
    @images = MediaTag.order('created_at ASC')
  end

  def admin_aprobar
    image = MediaTag.find(params[:id])
    image.toggle_approve if image
    redirect_to sephoralabios_admin_path
  end

  def index
    @images = MediaTag.approved.order('created_at ASC')
  end

  def suscribe
    render :text => "#{params['hub.challenge']}"
  end

  def fetcher
    Instagram.process_subscription(request.body.string) do |handler|
      handler.on_tag_changed do |tag, data|
        Instagram.tag_recent_media(tag).each do |data|
          MediaTag.parse data
        end
      end
    end
    render :text => ""
  end
end
