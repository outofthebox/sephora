require 'rake'

namespace :tiendas do
  task :populate_map => :environment do
    maps = [
      {:slug => "sephora-antara", :link => "https://www.google.com/maps/preview?q=19.4386559,-99.2033902"},
      {:slug => "sephora-interlomas", :link => "https://www.google.com/maps/preview?q=19.3971848241302,-99.2824548884216"},
      {:slug => "sephora-angelopolis", :link => "https://www.google.com.mx/maps/place/Luxury+Hall/@19.032038,-98.233517,17z/data=!3m1!4b1!4m2!3m1!1s0x85cfc739c0563fbf:0xb6580fbbe7015193?hl=es"},
      {:slug => "sephora-satelite", :link => "https://www.google.com/maps/preview?q=19.5097643,-99.2329423"},
      {:slug => "sephora-andares", :link => "https://www.google.com/maps/preview?q=20.7102965521529,-103.412185762921"},
      {:slug => "sephora-santa-fe", :link => "https://www.google.com.mx/maps/search/Avenida+Vasco+de+Quiroga+3850,+Colonia+Santa+Fe+Cuajimalpa,+Delegaci%C3%B3n+Cuajimalpa,+CP:+05109,+M%C3%A9xico,+D.F./@19.36172,-99.2725392,17z?hl=es"},
      {:slug => "sephora-galerias-guadalajara", :link => "https://www.google.com/maps/preview?q=20.674853845236,-103.430110417722"},
      {:slug => "sephora-coyoacan", :link => "https://www.google.com.mx/maps/search/Avenida+Coyoac%C3%A1n+2000+Colonia+Xoco+Delegacion+Benito+Ju%C3%A1rez+M%C3%A9xico+Distrito+Federal/@19.3598995,-99.1701341,19z?hl=es"},
      {:slug => "sephora-antea-queretaro", :link => "https://www.google.com/maps/place/20%C2%B040'28.6%22N+100%C2%B026'11.1%22W/@20.6746091,-100.4364188,17z/data=!3m1!4b1!4m2!3m1!1s0x0:0x0"},
    ]

    maps.each do |map|
      begin
        slug = map[:slug]
        link = map[:link]
        Tienda.find_by_slug(slug).update_attribute(:map, link)
      rescue Exception => e
        puts e
      end
    end
  end
end