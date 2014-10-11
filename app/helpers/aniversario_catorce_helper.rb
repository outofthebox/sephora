module AniversarioCatorceHelper
	def restricted date, link
		date = date.split(",")
		fecha = DateTime.new(date[0].to_i,date[1].to_i,date[2].to_i,date[3].to_i,date[4].to_i,date[5].to_i)
		unless fecha <= DateTime.current()
			"#"
		else
			link
		end
	end

	def coming_soon?(date)
		date = date.split(",")
		fecha = DateTime.new(date[0].to_i,date[1].to_i,date[2].to_i,date[3].to_i,date[4].to_i,date[5].to_i)
		DateTime.current() < fecha 
	end
end
