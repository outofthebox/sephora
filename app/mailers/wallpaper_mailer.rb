#encoding: UTF-8
class WallpaperMailer < ActionMailer::Base
  include SendGrid
  default from: "sephora@outofthebox.mx", :charset => "UTF-8"
  layout 'mail'
  def enviarmail(imagen, mail)
    imagen = imagen.gsub(/-.*$/, '')
    attachments.inline["#{imagen}.jpg"] = File.read(Rails.root.join("public/wallpapers/#{imagen}.jpg"))
    mail(:to => mail, :subject => "¡Descarga tu wallpaper extraordinario!", :body => ' Tu wallpaper ya está listo para que lo descargues. ¡Disfrútalo y únete a la celebración de una Navidad extraordinaria!')
  end
end
