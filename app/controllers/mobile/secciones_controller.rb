class Mobile::SeccionesController < MobileController
  def show
    @seccion = Seccion.by_slug(params[:seccion])
    if @seccion != false and !@seccion.nil?
      @contenido = Seccion.seccion_actual(@seccion)
    else
      redirect_to root_path
    end
  end

  def mascarillashidratantes
    @face_mask = [{
      name:"Honey",
      link: "http://www.sephora.com.mx/producto/sleeping-mask-honey-3378872089827?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Sleeping",
      image: "masks/mask_party/Honey.png"
    },{
      name:"Lingzhi",
      link: "http://www.sephora.com.mx/producto/sleeping-mask-lingzhi-3378872089889?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Sleeping",
      image: "masks/mask_party/Lingzhi.png"
    },{
      name:"Pearl",
      link: "http://www.sephora.com.mx/producto/sleeping-mask-pearl-3378872089896?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Sleeping",
      image: "masks/mask_party/Pearl.png"
    },{
      name:"Ginseng",
      link: "http://www.sephora.com.mx/producto/sleeping-mask-ginseng-3378872089872?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Sleeping",
      image: "masks/mask_party/Ginseng.png"
    },{
      name:"Lotus",
      link: "http://www.sephora.com.mx/producto/sleeping-mask-lotus-3378872089841?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Sleeping",
      image: "masks/mask_party/Lotus.png"
    },{
      name:"Rose",
      link: "http://www.sephora.com.mx/producto/sleeping-mask-rose-3378872089858?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Sleeping",
      image: "masks/mask_party/Rose.png"
    },{
      name:"Green Tea Mask",
      link: "http://www.sephora.com.mx/producto/sleeping-mask-green-tea-3378872089865?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Sleeping",
      image: "masks/mask_party/Green.png"
    },{
      name:"Promegranate Mask",
      link: "http://www.sephora.com.mx/producto/sleeping-mask-pomegranate-3378872089834?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Sleeping",
      image: "masks/mask_party/Promegranate.png"
    }]
    render "mask_party"
  end
  def mascarillasantiedad
    @face_mask = [{
      name: "Honey",
      link: "http://www.sephora.com.mx/producto/face-mask-honey-3378872082255?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Face",
      image: "masks/mask_face/Honey.png"
    },{
      name: "Pearl",
      link: "http://www.sephora.com.mx/producto/face-mask-pearl-3378872082323?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Face",
      image: "masks/mask_face/Pearl.png"
    },{
      name: "Ginseng",
      link: "http://www.sephora.com.mx/producto/face-mask-ginseng-3378872082309?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Face",
      image: "masks/mask_face/Ginseng.png"
    },{
      name: "Green tea",
      link: "http://www.sephora.com.mx/producto/face-mask-green-tea-3378872082293?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Face",
      image: "masks/mask_face/Green.png"
    },{
      name: "Rose Mask",
      link: "http://www.sephora.com.mx/producto/face-mask-rose-3378872082286?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Face",
      image: "masks/mask_face/Rose.png"
    },{
      name: "Promegranate ",
      link: "http://www.sephora.com.mx/producto/face-mask-pomegranate-3378872082262?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Face",
      image: "masks/mask_face/Promegranate.png"
    },{
      name: "Lotus",
      link: "http://www.sephora.com.mx/producto/face-mask-lotus-3378872082279?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Face",
      image: "masks/mask_face/Lotus.png"
    },{
      name: "Lingzhi",
      link: "http://www.sephora.com.mx/producto/face-mask-lingzhi-3378872082316?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Face",
      image: "masks/mask_face/Lingzhi.png"
    }];
    render "mask_party"
  end
  def mascarillasmultibeneficio
    @face_mask = [{
      name: "Rose",
      link: "http://www.sephora.com.mx/producto/eye-mask-rose-3378872088882?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Eye",
      image: "masks/mask_eye/Rose.png"
    },{
      name: "Promegranate",
      link: "http://www.sephora.com.mx/producto/eye-mask-pomegranate-3378872088868?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Eye",
      image: "masks/mask_eye/Promegranate.png"
    },{
      name: "Ginseng",
      link: "http://www.sephora.com.mx/producto/eye-mask-ginseng-3378872088905?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Eye",
      image: "masks/mask_eye/Ginseng.png"
    },{
      name: "Lingzhi",
      link: "http://www.sephora.com.mx/producto/eye-mask-lingzhi-3378872088912?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Eye ",
      image: "masks/mask_eye/Lingzhi.png"
    },{
      name: "Lotus",
      link: "http://www.sephora.com.mx/producto/eye-mask-lotus-3378872088875?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Eye",
      image: "masks/mask_eye/Lotus.png"
    },{
      name: "Pearl",
      link: "http://www.sephora.com.mx/producto/eye-mask-pearl-3378872088929?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Eye",
      image: "masks/mask_eye/Pearl.png"
    },{
      name: "Honey",
      link: "http://www.sephora.com.mx/producto/eye-mask-honey-3378872088851?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Eye",
      image: "masks/mask_eye/Honey.png"
    },{
      name: "Green Tea",
      link: "http://www.sephora.com.mx/producto/eye-mask-green-tea-3378872088899?utm_source=SitioWeb&utm_medium=LandingMasks&utm_campaign=Eye",
      image: "masks/mask_eye/Green.png"
    }];
    render "mask_party"
  end
end
