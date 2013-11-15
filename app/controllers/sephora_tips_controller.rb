class SephoraTipsController < ApplicationController
  def index
		@tip = Tip.new
	end

	def post_tip
		@le_tip = params[:tip]

		@tip = Tip.new (@le_tip)

		# intenta guardar en base de datos
    if @tip.save
    else
    end
	end
end
