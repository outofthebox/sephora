require "csv"

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

	def admin
		@tips = Tip.all
	end

	def download
		@tips = Tip.all

		respond_to do |format|
      format.html
      format.csv { render text: Tip.to_csv}
    end

	end
end
