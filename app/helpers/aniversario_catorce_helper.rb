module AniversarioCatorceHelper
	def restricted date, link
		date = date.split(",")
		if date[3] == "17"
			fecha = DateTime.new(date[0].to_i,date[1].to_i,date[2].to_i,17,date[4].to_i,date[5].to_i, "-05:00")
		else
			fecha = DateTime.new(date[0].to_i,date[1].to_i,date[2].to_i,11,date[4].to_i,date[5].to_i, "-05:00")
		end
		unless fecha <= DateTime.current()
			"#"
		else
			link
		end
	end

	def coming_soon?(date)
		fecha = nil
		date = date.split(",")
		if date[3] == "17"
			fecha = DateTime.new(date[0].to_i,date[1].to_i,date[2].to_i,17,date[4].to_i,date[5].to_i, "-05:00")
		else
			fecha = DateTime.new(date[0].to_i,date[1].to_i,date[2].to_i,11,date[4].to_i,date[5].to_i, "-05:00")
		end
		DateTime.current() < fecha 
	end
end
