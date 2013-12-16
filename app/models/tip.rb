class Tip < ActiveRecord::Base
	has_attached_file :foto, {
    :styles => {
      :small => ["230x250>"],
      :medium => ["550X590"]
    }
  }.merge(PAPERCLIP_STORAGE_OPTIONS)
	
	def to_param
	"#{id}-#{slug}"
	end

	def self.to_csv
		csv_string = CSV.generate do |csv|
			csv << ["folio", "nombre", "correo", "tip", "imagen"]
		  all.each do |tip|
		  	csv << [tip.id, tip.nombre, tip.correo, tip.tip, tip.foto(:medium)]
		  end
		end
	end
end
