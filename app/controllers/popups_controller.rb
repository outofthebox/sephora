class PopupsController < Administracion::PopupsController
  def subscribe
    sc = SimioCartero.new
    
    @response = 500
    
    information = {}
    information[:NAME] = params[:name] if params[:name].present?
    information[:EMAIL] = params[:email] if params[:email].present?
    information[:DOB] = params[:bod] if params[:bod].present?
    information[:STOREID] = params[:store] if params[:store].present? 

    @response = 200 if information[:EMAIL].present? && sc.suscribe_to(information)

    respond_to do |format|
      format.js
    end
  end
end
