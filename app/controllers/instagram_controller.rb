class InstagramController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
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
