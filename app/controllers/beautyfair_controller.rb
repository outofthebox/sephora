class BeautyfairController < ApplicationController
  layout :select_beauty_layout
  
  def home; end
  def tour; end
  def playa; end

  def select_beauty_layout
    case action_name
    when "antara"
      return 'beautyfair_2'
    else
      return 'beautyfair'
    end
  end
end
