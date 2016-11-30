class InitiativesController < ApplicationController
  before_action :set_initiative, only: [:show, :edit, :update, :destroy]

  # GET /initiatives
  def index
    @initiatives = Initiative.all
  end

  # GET /initiatives/1
  def show
  end

  # GET /initiatives/new
  def new
    @initiative = Initiative.new
  end

  # GET /initiatives/1/edit
  def edit
  end

  # POST /initiatives
  def create
    @initiative = Initiative.new(initiative_params)

    if @initiative.save
      redirect_to @initiative, notice: 'Initiative was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /initiatives/1
  def update
    if @initiative.update(initiative_params)
      redirect_to @initiative, notice: 'Initiative was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /initiatives/1
  def destroy
    @initiative.destroy
    redirect_to initiatives_url, notice: 'Initiative was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_initiative
      @initiative = Initiative.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def initiative_params
      params.require(:initiative).permit(:title, :description, :link)
    end
end
