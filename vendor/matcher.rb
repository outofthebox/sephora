raw = Dir.glob("/home/sputnik3/Desktop/sephora/**/*.jpg")

# raw = raw[0, 1000]

require 'pathname'
img = {}
raw.each{|i|
  i_sku = Pathname.new(i).basename.to_s[/([0-9]+)/]
  img[i_sku.to_sym] = i
}


require 'csv'
require 'fileutils'
notfound = []
csv = "/home/sputnik3/Desktop/sephora.csv"
CSV.foreach(csv) do |row|
  sku = row[1]
  if img.keys.include? sku.to_sym
    FileUtils.cp img[sku.to_sym], "/home/sputnik3/Desktop/sephora_filtrados/#{sku}.jpg"
  else
    notfound << row[1]
  end
end

puts "no encontrados: #{notfound.size}"
puts notfound
