class SephoraCollectionController < ApplicationController
  before_filter :set_bg_white, :only => :maquillaje
  before_filter :set_bg_black, :only => :index

  def index
  end

  def maquillaje
  end

  private

  def set_bg_white
    @background = "white"
  end

  def set_bg_black
    @background = "black"
  end
end
