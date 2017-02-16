require 'ostruct'
require 'gibbon'

class SimioCartero
	def initialize; @conn = Gibbon::API.new(ENV['MAILCHIMP_API_KEY']) end
	def conn; @conn ||= Gibbon::API.new(ENV['MAILCHIMP_API_KEY']) end

	def suscribe_to(params = nil, id_list = nil)
		id_list ||= ENV["MAILCHIMP_LIST_ID"]
		
		email = params[:EMAIL] if params[:EMAIL].present?
		name = params[:NAME] if params[:NAME].present?
		
		merge_vars = ( params[:NAME].present? ) ? {:NAME => name } : {}

		unless params[:to_merge_vars].nil?
			merge_vars.merge!(params[:to_merge_vars])
		end

		begin
			information = {
		  	id: id_list, 
		  	email: { email: email }, 
		  	merge_vars: merge_vars,
		  	double_optin: false, 
		  	update_existing: true
		  }
		  @conn.lists.subscribe(information)
		rescue Gibbon::MailChimpError => e
		  return e.message
		end
	end

	def batch_update_or_create(id_list = nil, batch = [])
		@conn.lists.subscribe({:id => id_list, :batch => batch, :double_optin => false, :update_existing => true})
	end

	def lists
		@conn.lists.list({:start => 0, :limit => 100})["data"].map{|x| {id: x["id"], name: x["name"]}}
	end

	def find_list_members(list_id)
		@conn.lists.members({:id => list_id})
	end
end