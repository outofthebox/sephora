class FriendsandfamilyController < ApplicationController
	def index
		redirect_to friendsandfamily_ya_descargaste_path if cookies["redemption"]
	end

	def code
		begin
			code = params[:codigo];
			rd = Redemption.find_by_code(code)
			unless rd && rd.count > 0
				redirect_to friendsandfamily_index_path
			else
				@link = "https://s3.amazonaws.com/sephoragess/friendsandfamily/cupon_#{code}.pdf"
			end
		rescue Exception => e
			redirect_to friendsandfamily_index_path
		end		
	end

	def gracias
		cookies["redemption"] = true
	end

	def ya_descargaste
	end

	def delete_cookie
		cookies.delete :redemption if cookies["redemption"]
		redirect_to friendsandfamily_index_path
	end

	def get_pdf
	end
end
