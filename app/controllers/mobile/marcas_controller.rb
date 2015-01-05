class Mobile::MarcasController < MobileController
	before_filter :set_marca_by_slug, :only => [:show]
	before_filter :get_parent_categories, :only => [:show]

	def index
		@marcas = Marca.find(:all, :order =>"marca ASC").group_by{|u| u.marca[0].upcase}
	end

	def show
		f_cat = []
    @f_parent = []

    pic = Producto.includes(:categoria).where(:marca_id => @marca.id).where(:publicado => true);
    pic.each do |t| f_cat << t.categoria.nombre rescue nil end
    @categorias = f_cat.uniq.sort

    @parent_categories.each do |pc|
      child_cats = Categoria.where(:parent_id => pc.id).pluck(:id) rescue []
      child_cats << pc.id
      p_count = pic.where(:categoria_id => child_cats).where(:parent_id => nil).count
      @f_parent << {:id => pc.id, :categoria => pc.nombre, :product_count => p_count, :slug => pc.slug}
     end
	end
	
	private

	def set_marca_by_slug
		slug = params[:id] rescue nil
		if slug
			@marca = Marca.find_by_slug(slug)
		else
			redirect_to m_marcas_path
		end
	end

	def get_parent_categories
		@parent_categories = Categoria.where(:parent_id => nil)
	end

	def get_descendants(parent_categories)
		cats = []
		parent_categories.each do |pc|
			categoria = pc
			childrens = (pc.children.any?) ? get_descendants(pc.children) : nil
			cats << {categoria:categoria, childrens: childrens}
		end
		cats
	end

	def get_marca_categories
		@productos_en_categoria = Producto.includes(:categoria).where(:publicado => true, :marca_id => @marca.id)
		@categorias = @productos_en_categoria.map{|c| c.categoria}.uniq.sort
	end
end

