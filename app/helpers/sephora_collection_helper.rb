#!/bin/env ruby
# encoding: utf-8

module SephoraCollectionHelper
  def get_musts
    musts = [
      'Labios camaleónicos. 12 tonos para elegir. Rouge Infusion Lip Ink $225',
      '¿Look natural, glamoroso o sofisticado? ¡Tú decides! Rouge Infusion Lip Ink $225',
      'Crea pestañas glamorosas, extravagantes, con ultra volumen, en un solo paso. Outrageous Volume Mascara. $245',
      'Olvídate de esperar años para que sequen tus uñas, Color Hit te da secado rápido y 5 días de brillo. $90',
      'Lleva en tus manos desde nudes hasta neones, ¡tienes 49 opciones para elegir! Color Hit. $90',
      '60 tonos y 4 efectos diferentes para looks ilimitados ¿Lista para revelar tu personalidad? Colorful Eyeshadows. $200',
      'Intensifica tu mirada con delineados a color ¡24 Horas a prueba de todo! Colorful Waterproof Eyeliner 24 HR Wear. $175',
      '¡Aprende a maquillarte como una PRO! Maquillaje y tutos para crear un look totalmente irresistible. Pro Lesson Palette. $475',
      'Matices brillantes, destellantes y metálicos, el toque final que tu sonrisa necesita. Rouge Shine Lipstick. $200',
      'No necesitas ir a Brasil para lograr un bronceado de envidia en tu rostro. Sol de Río Bronzer. $350'
    ]
    musts.sample
  end

  def get_tips
    tips = ["Si tu piel es seca usa maquillajes líquidos y si es grasa opta por maquillajes en polvo. #SephoraTrick","Para encontrar tu tono correcto de base, pruébala sobre tu mandíbula, si se difumina por completo en tu piel, encontraste tu tono ideal. #SephoraTrick","Aplica una capa de lip stain antes de tu lipstick, así, si éste se desvanece, aún tendrás color en tus labios. #SephoraTrick","Al aplicar tu mascara enfócate en el centro de las pestañas superiores, así agrandarás tu mirada. #SephoraTrick","Si quieres pestañas con mayor volumen busca una mascara con un cepillo grueso, y si lo que buscas es rizarlas busca uno curvo. #SephoraTrick","Antes de aplicar tu esmalte limpia tu uña con removedor de esmalte, así limpiarás la superficie y la aplicación será mejor. #SephoraTrick","Consigue un color más intenso humedeciendo la brocha al aplicar tus sombras en polvo. #SephoraTrick","Si tienes una sombra tono vainilla puedes usarla para iluminar tu mirada, aplícala debajo de la ceja y al lado del lagrimal. #SephoraTrick","Para que tu delineador dure por más tiempo, aplica antes un poco de sombra del mismo tono, así se fijará y el color será más intenso. #SephoraTrick","¡Atrévete a romper las reglas! Lleva un doble delineado en tonos contrastantes para darle un twist a tu look. #SephoraTrick","Para que tu lipstick dure por más tiempo aplícalo por capas: Aplica una capa, besa un pañuelo y repite el paso. #SephoraTrick","Los tonos de lipstick de la temporada son anaranjado y rosa, si te atreves a llevarlos mantén el resto de tu maquillaje sutil. #SephoraTrick","Si quieres lograr unos labios con mayor volumen delinéalos por fuera con el delineador universal de Sephora Collection. #SephoraTrick"]
    tips.sample
  end

  def get_texture
    index = [1,2,3,4,5,6,7,8,9].sample
    "sephora_collection/texturas/maquillaje/m_textura#{index}.jpg"
  end
end
