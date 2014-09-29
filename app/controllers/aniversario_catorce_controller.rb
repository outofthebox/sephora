class AniversarioCatorceController < ApplicationController
	before_filter :find_marca_by_name, :only => [:ver_marca]
	
	def index
		@catalogo_home = get_catalogo["marcas"]
	end

	def ver_marca
		@img = @marca["imagen"]
		@nombre = @marca["nombre"]
		@titulo = @marca["titulo"]
		@acerca = @marca["acerca"]
		@descripcion = @marca["descripcion"]
		@board = @marca["board"]
	end

	private

	def get_catalogo
		catalogo_aniversario_path = File.join(Rails.root, 'db', 'collections', 'catalogo_aniversario.yml');
		catalogo = YAML.load(File.open(catalogo_aniversario_path))
	end

	def find_marca_by_name
		name = params[:marca]
		marcas = get_catalogo["marcas"]
		marcas.each do |m|
			marca = m[1]
			@marca = marca if marca["nombre"].parameterize == name
		end
	end	

	def get_marca
		id = params[:marca]
		@marca = get_catalogo["marcas"][id]
	end

end
