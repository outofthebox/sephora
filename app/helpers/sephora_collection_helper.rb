#!/bin/env ruby
# encoding: utf-8
module SephoraCollectionHelper
  def get_tips
    interna = params[:interna]
    tips = {
      :maquillaje => [],
      :skincare => [],
      :bath => [],
      :accesorios => []
    }

    if ["maquillaje", "skincare", "accesorios", "bath"].include?(interna)
      collection = interna
    else
      collection = "maquillaje"
    end

    tips[:maquillaje] = [
      "Si tu piel es seca usa maquillajes líquidos y si es grasa opta por maquillajes en polvo. #SephoraTrick",
      "Para encontrar tu tono correcto de base, pruébala sobre tu mandíbula, si se difumina por completo en tu piel, encontraste tu tono ideal. #SephoraTrick",
      "Aplica una capa de lip stain antes de tu lipstick, así, si éste se desvanece, aún tendrás color en tus labios. #SephoraTrick",
      "Al aplicar tu mascara enfócate en el centro de las pestañas superiores, así agrandarás tu mirada. #SephoraTrick",
      "Si quieres pestañas con mayor volumen busca una mascara con un cepillo grueso, y si lo que buscas es rizarlas busca uno curvo. #SephoraTrick",
      "Antes de aplicar tu esmalte limpia tu uña con removedor de esmalte, así limpiarás la superficie y la aplicación será mejor. #SephoraTrick",
      "Consigue un color más intenso humedeciendo la brocha al aplicar tus sombras en polvo. #SephoraTrick",
      "Si tienes una sombra tono vainilla puedes usarla para iluminar tu mirada, aplícala debajo de la ceja y al lado del lagrimal. #SephoraTrick",
      "Para que tu delineador dure por más tiempo, aplica antes un poco de sombra del mismo tono, así se fijará y el color será más intenso. #SephoraTrick",
      "¡Atrévete a romper las reglas! Lleva un doble delineado en tonos contrastantes para darle un twist a tu look. #SephoraTrick",
      "Para que tu lipstick dure por más tiempo aplícalo por capas: Aplica una capa, besa un pañuelo y repite el paso. #SephoraTrick",
      "Los tonos de lipstick de la temporada son anaranjado y rosa, si te atreves a llevarlos mantén el resto de tu maquillaje sutil. #SephoraTrick",
      "Si quieres lograr unos labios con mayor volumen delinéalos por fuera con el delineador universal de Sephora Collection. #SephoraTrick",
      "Aplica tu bronzer sobre tu frente, pómulos, nariz y mentón, ya que estas son las zonas que se broncean de forma natural por el sol. #SephoraTrick"
    ]

    tips[:skincare] = [
      "Un par de días antes de aplicar tu autobronceador realiza una exfoliación, así conseguirás un tono parejo y luminoso. #SephoraTrick",
      "Al aplicar tu auto bronceador comienza de abajo hacia arriba, esto facilitará su aplicación. #SephoraTrick",
      "Si tienes piel grasa opta por hidratante oil-free, de esta manera hidratarás tu piel y no obtendrás brillo en la zona T. #SephoraTrick",
      "La cantidad exacta que debes usar de tu crema de ojos es del tamaño de un grano de arroz. #SephoraTrick",
      "Para potencializar los beneficios de tu crema de ojos, métela al refrigerador durante unos minutos antes de usarla. #SephoraTrick",
      "Se recomienda usar sueros a partir de los 25 años, cuando la regeneración de las células comienza a disminuir. #SephoraTrick",
      "Aplica tu suero facial después del tónico y antes de tu crema hidratante para aprovechar al máximo sus beneficios. #SephoraTrick",
      "Rocía un poco de tónico en tu rostro después de desmaquillarte, conseguirás una sensación de frescura y suavidad en tu piel. #SephoraTrick",
      "No desmaquillarte una noche envejece a tu piel 5 días, evita ir a dormir maquillada, tu piel lo agradecerá. #SephoraTrick",
      "Aplica tu mascarilla de una a dos veces por semana para obtener los resultados deseados. #SephoraTrick",
      "Hay mascarillas para hidratar, reducir líneas de expresión o desintoxicar. Elige tu necesidad y comienza a usarla. #SephoraTrick",
      "Si tu piel es grasa o sensible, exfolia tu rostro una vez a la semana y si es normal, puedes hacerlo 2 veces por semana. #SephoraTrick",
      "Si quieres una exfoliación más profunda, aplica tu exfoliante en movimientos circulares con un cepillo para el cuerpo. #SephoraTrick"
    ]

    tips[:accesorios] = [
      "Si buscas una cobertura completa aplica tu base con una brocha, y si quieres un efecto natural usa tus dedos. #SephoraTrick",
      "Lava tus brochas una vez al mes con un limpiador especial para retirar cualquier residuo de maquillaje y bacterias. #SephoraTrick",
      "Para mantener en buen estado tu delineador busca un sacapuntas especial para maquillaje, el resultado se reflejará en tu look. #SephoraTrick",
      "Para realizar tu manicure sigue los siguientes pasos: lima, remueve la cutícula, pule tus uñas, exfolia y aplica color ¡fácil! #SephoraTrick",
      "5 herramientas para toda amante de la belleza: Rizador, sacapuntas, espejo, pinza para cejas y brocha ¡Que no te falte ninguna! #SephoraTrick",
      "Usa tu rizador antes de aplicar tu mascara, si lo haces después de aplicarlo puedes correr el riesgo de que se quiebren. #SephoraTrick",
      "Coloca tu rizador en la raíz de las pestañas y presiona suavemente, sube al centro y repite para lograr un rizado natural. #SephoraTrick",
      "Remueve las cejas rebeldes después de bañarte cuando tus poros están abiertos ¡Saldrán fácilmente! #SephoraTrick",
      "Las brochas de cerdas naturales son perfectas para maquillaje en polvo mientras que las sintéticas son ideales para cremas y líquidos. #SephoraTrick",
      "Las brochas indispensables para tu cosmetiquera: Brocha para polvos, base líquida, sombras, blush y cejas. #SephoraTrick",
      "Usa tu esponja húmeda o seca según el efecto que busques: Úsala húmeda para una cobertura ligera y seca para una cobertura total. #SephoraTrick"
    ]

    tips[:bath] =[
      "Aplica tu hidratante después de bañarte cuando la piel sigue húmeda, la absorción será mayor y la humectación durará más tiempo.#SephoraTrick",
      "Para una correcta hidratación busca un hidratante ideal para tu tipo de piel, eso marcará una diferencia en la luminosidad de tu piel. #SephoraTrick",
      "Consiéntete con aromas relajantes, busca un set de gel de baño, limpiador e hidratante para extender la fragancia. #SephoraTrick",
      "Inicia tu ducha con agua tibia y finaliza con fría, esto ayudará a la circulación y comenzarás el día con más energía.#SephoraTrick",
      "Aprovecha el fin de semana para un baño en tu tina, agrega un cubo efervescente para suavizar tu piel y desestresarte. #SephoraTrick",
      "Después de un largo día toma una ducha de agua caliente, te servirá de relajante y te ayudará a dormir mejor. #SephoraTrick",
      "Para mantener la piel de tu cuerpo tersa, usa un exfoliante suave una vez por semana. #SephoraTrick"
    ]

    tips[collection.to_sym].sample
  end

  def get_musts
    #musts = ["Si tu piel es seca usa maquillajes líquidos y si es grasa opta por maquillajes en polvo. #SephoraTrick","Para encontrar tu tono correcto de base, pruébala sobre tu mandíbula, si se difumina por completo en tu piel, encontraste tu tono ideal. #SephoraTrick","Aplica una capa de lip stain antes de tu lipstick, así, si éste se desvanece, aún tendrás color en tus labios. #SephoraTrick","Al aplicar tu mascara enfócate en el centro de las pestañas superiores, así agrandarás tu mirada. #SephoraTrick","Si quieres pestañas con mayor volumen busca una mascara con un cepillo grueso, y si lo que buscas es rizarlas busca uno curvo. #SephoraTrick","Antes de aplicar tu esmalte limpia tu uña con removedor de esmalte, así limpiarás la superficie y la aplicación será mejor. #SephoraTrick","Consigue un color más intenso humedeciendo la brocha al aplicar tus sombras en polvo. #SephoraTrick","Si tienes una sombra tono vainilla puedes usarla para iluminar tu mirada, aplícala debajo de la ceja y al lado del lagrimal. #SephoraTrick","Para que tu delineador dure por más tiempo, aplica antes un poco de sombra del mismo tono, así se fijará y el color será más intenso. #SephoraTrick","¡Atrévete a romper las reglas! Lleva un doble delineado en tonos contrastantes para darle un twist a tu look. #SephoraTrick","Para que tu lipstick dure por más tiempo aplícalo por capas: Aplica una capa, besa un pañuelo y repite el paso. #SephoraTrick","Los tonos de lipstick de la temporada son anaranjado y rosa, si te atreves a llevarlos mantén el resto de tu maquillaje sutil. #SephoraTrick","Si quieres lograr unos labios con mayor volumen delinéalos por fuera con el delineador universal de Sephora Collection. #SephoraTrick"]

    interna = params[:interna]
    musts = {
      :maquillaje => [],
      :skincare => [],
      :bath => [],
      :accesorios => []
    }

    if ["maquillaje", "skincare", "accesorios", "bath"].include?(interna)
      collection = interna
    else
      collection = "maquillaje"
    end

    musts[:maquillaje] = [
      "Oculta en segundos cualquier imperfección con una cobertura total durante 10 horas ¡Es real! 10 HR Wear Perfection Foundation $300",
      "Labios camaleónicos. 12 tonos para elegir. Rouge Infusion Lip Ink $225",
      "¿Look natural, glamoroso o sofisticado? ¡Tú decides! Rouge Infusion Lip Ink $225",
      "Crea pestañas glamorosas, extravagantes, con ultra volumen, en un solo paso. Outrageous Volume Mascara. $245",
      "Olvídate de esperar años para que sequen tus uñas, Color Hit te da secado rápido y 5 días de brillo. $90",
      "Lleva en tus manos desde nudes hasta neones, ¡tienes 49 opciones para elegir! Color Hit. $90",
      "60 tonos y 4 efectos diferentes para looks ilimitados ¿Lista para revelar tu personalidad? Colorful Eyeshadows. $200",
      "Intensifica tu mirada con delineados a color ¡24 Horas a prueba de todo! Colorful Waterproof Eyeliner 24 HR Wear. $175 ",
      "¡Aprende a maquillarte como una PRO! Maquillaje y tutos para crear un look totalmente irresistible. Pro Lesson Palette. $475",
      "Matices brillantes, destellantes y metálicos, el toque final que tu sonrisa necesita. Rouge Shine Lipstick. $200",
      "No necesitas ir a Brasil para lograr un bronceado de envidia en tu rostro. Sol de Río Bronzer. $350"
    ]

    musts[:skincare] = [
      "Disfruta de destellos de sol e hidratación en un solo paso. Moisturizing Bronzing Body Lotion. $210",
      "Un shot de ultra hidratación 24/7 es lo que tu piel necesita para un resplandor natural. Intensive Instant Moisturizer. $310",
      "¡Bye, bye ojeras e hinchazón! Y si reduce las líneas de expresión, es un MUST. Age Defy Eye Cream. $400",
      "¡¿Te imaginas un suero con la textura de un aceite?! Ya no lo imagines ,¡lo tenemos para ti! Regenerating Oil- Serum. $380",
      "Refresca y consiente a tu piel después de desmaquillarte ¡El toque de frescura que necesitabas! Instant Refreshing Toner. $195",
      "¡No hay pretextos! Limpia tu piel y remueve toda impureza en donde quiera que estés. Express Waterproof Cleansing Wipes. $150",
      "¡S.O.S. Sephora! Despídete de los ojos hinchados en minutos. 1p1s Instant Depuffing Eye Mask. $105",
      "La exfoliación es el secreto para renovar la belleza de tu piel y darle la bienvenida a una piel más luminosa. Sugar Body Scrub. $290"
    ]

    musts[:accesorios] = [
      "¡Tu BF para la cobertura deseada! De un lado es para bases líquidas y del otro es perfecto para polvos. Double-Ended Perfect Complexion Brush. $590",
      "La diferencia entre un buen delineado y un delineado perfecto. Nano Sharpener. $55",
      "Para los retoques en el camino, este es el indispensable que siempre debe estar en tu bolso. Jeweled Compact Mirror. $300",
      "El paso final para un mani ultra chic, uñas hermosas y brillantes. 4 Step Buffer Repack. $90",
      "Pestañas perfectas… ¡a prueba de pellizcos! Eyelash Curler. $265 ",
      "Elimina las cejas rebeldes y defínelas con la herramienta ideal para lograrlo. Stainless Steel Tweezers. $165",
      "¿Viajes en puerta? Lleva contigo tu perfume favorito y olvídate de los accidentes al llevar tu frasco completo. Universal Atomizer $320",
      "Para ojos, mejillas y labios: Todo lo que necesitas en un estuche muy chic. Deluxe Antibacterial Brush Set. $1,000",
      "Llega a cada rincón de tu rostro y logra el cutis perfecto con la esponja 3D favorita de los expertos. Precision Sponge 3D $245"
    ]

    musts[:bath] = [
      "La manteca de karité y el Hydrosenn+ se unen para regalarte una piel ULTRA suave. Nourishing Body Butter. $245",
      "Siente una explosión de suavidad y frescura al estilo brasileño en la ducha, ¡bienvenida a la fiesta! Body Moisturizing Sorbet Agua de Río. $260",
      "¡Colores y fórmulas cremosas para una dosis de felicidad! Body Wash Caps. $20",
      "Limpieza y suavidad con el toque ideal de diversión para alegrar tu mood. Creamy Body Wash $70",
      "¡Es hora de relajarte! Uno de estos cubitos es lo que necesitas para consentirte. Fizzing Cube. $25",
      "Ahora el baño se convertirá en un coctel de frutas tropicales ¡Prepárate para disfrutarlo! Bubble Bath & Shower Gel Agua de Río. $160",
      "Exfolia tu cuerpo una vez por semana y logra una piel suave, tersa y delicadamente perfumada. Body Scrub. $150"
    ]

    musts[collection.to_sym].sample
  end

  def get_texture
    index = [1,2,3,4,5,6,7,8,9].sample
    "sephora_collection/texturas/maquillaje/m_textura#{index}.jpg"
  end
end
