class InstagramController < ApplicationController
  def index
  	@instagram = Instagram.tag_recent_media("GiftmaniaSephora", {:count => 8})
  end

  def new_stuff
    Instagram.process_subscription(request.body.string) do |handler|
      handler.on_tag_changed do |tag, data|
        Instagram.tag_recent_media(tag).data.each do |data|
          puts data.inspect
        end
      end
    end
    render :text => ""
  end

  def suscribir
    render :text => "#{params['hub.challenge']}"
  end
end
