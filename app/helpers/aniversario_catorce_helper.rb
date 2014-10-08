module AniversarioCatorceHelper
	def restricted day, link
		unless DateTime.new(2014,10,day,00,00,00) <= DateTime.current()
			"#"
		else
			link
		end
	end
end
