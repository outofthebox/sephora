class AniversarioCatorceController < ApplicationController
	before_filter :find_marca_by_name, :only => [:ver_marca]

	def index
		@catalogo_home = get_catalogo["marcas"]
	end

	def big_prices; end
	def beauty_trip; end
	
	def trivia_start
		redirect_to aniversario_catorce_beauty_trip_path if cookies[:trivia_user].empty?
	end

	def trivia_init
		usuario_trivia = UsuarioTrivia.find_by_ticket(params_user_trivia[:ticket])
		unless usuario_trivia
			usuario_trivia = UsuarioTrivia.new(params_user_trivia)
			if usuario_trivia.save!
				cookies[:trivia_user] = usuario_trivia.id
				redirect_to aniversario_catorce_beauty_trip_start_path
			end
		else
			redirect_to aniversario_catorce_beauty_trip_path
		end	
	end

	def trivia_finish
		usuario_trivia_id = cookies[:trivia_user];
		usuario_trivia = UsuarioTrivia.find(usuario_trivia_id);
		if usuario_trivia
			usuario_trivia.update_attribute(:respuestas, params[:data].to_s)
			cookies[:trivia_user] = nil
			render json: {:respuesta => "salvado con exito", :error => false}.to_json
		else
			render json: {:respuesta => "algo no salio bien", :error => true}.to_json
		end
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

	def params_user_trivia
		params[:usuario_trivia]
	end

end
