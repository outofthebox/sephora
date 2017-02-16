class PopupsController < AdministracionController
  # GET /popups
  # GET /popups.json
  def index
    @popups = Popup.all

    #@popups = []

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @popups }
    end
  end

  # GET /popups/1
  # GET /popups/1.json
  def show
    @popup = Popup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @popup }
    end
  end

  # GET /popups/new
  # GET /popups/new.json
  def new
    @popup = Popup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @popup }
    end
  end

  # GET /popups/1/edit
  def edit
    @popup = Popup.find(params[:id])
  end

  # POST /popups
  # POST /popups.json
  def create
    @popup = Popup.new(params[:popup])

    respond_to do |format|
      if @popup.save
        format.html { redirect_to @popup, notice: 'Popup was successfully created.' }
        format.json { render json: @popup, status: :created, location: @popup }
      else
        format.html { render action: "new" }
        format.json { render json: @popup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /popups/1
  # PUT /popups/1.json
  def update
    @popup = Popup.find(params[:id])

    respond_to do |format|
      if @popup.update_attributes(params[:popup])
        format.html { redirect_to @popup, notice: 'Popup was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @popup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /popups/1
  # DELETE /popups/1.json
  def destroy
    @popup = Popup.find(params[:id])
    @popup.destroy

    respond_to do |format|
      format.html { redirect_to popups_url }
      format.json { head :no_content }
    end
  end
end
