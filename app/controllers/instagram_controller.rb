class InstagramController < ApplicationController
  def index
  	@fotos = Foto.where(:publicado => false).order('created_at DESC').all
  end

  def new_stuff
    Instagram.process_subscription(request.body) do |handler|
      handler.on_tag_changed do |tag, data|
        Instagram.tag_recent_media(tag).data.each do |data|
          puts data.inspect
          sephoragram = Sephoragram.find_or_create_by_instagram_id(
            :instagram_id => data.id,
            :instagram_link => data.link,
            :pic_thumb => data.images.thumbnail.url,
            :pic_med => data.images.low_resolution.url,
            :pic_large => data.images.standard_resolution.url,
            :fullname => data.user.full_name,
            :username => data.user.username
          )
          sephoragram.save
        end
      end
    end
    render :text => ""
  end

  def suscribir
    render :text => "#{params['hub.challenge']}"
  end
end
