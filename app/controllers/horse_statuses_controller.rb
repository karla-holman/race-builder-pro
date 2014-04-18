class HorseStatusesController < ApplicationController
  before_action :set_horse_status, only: [:show, :edit, :update, :destroy]

  # GET /horse_statuses
  # GET /horse_statuses.json
  def index
    @horse_statuses = HorseStatus.all
  end

  # GET /horse_statuses/1
  # GET /horse_statuses/1.json
  def show
  end

  # GET /horse_statuses/new
  def new
    @horse_status = HorseStatus.new
    @horses = Horse.all
    @statuses = Status.all
  end

  # GET /horse_statuses/1/edit
  def edit
    @horses = Horse.all
    @statuses = Status.all
  end

  # POST /horse_statuses
  # POST /horse_statuses.json
  def create
    @horse_status = HorseStatus.new(horse_status_params)

    respond_to do |format|
      if @horse_status.save
        format.html { redirect_to horse_statuses_url, notice: 'Horse status was successfully created.' }
        format.json { render action: 'show', status: :created, location: @horse_status }
      else
        format.html { render action: 'new' }
        format.json { render json: @horse_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /horse_statuses/1
  # PATCH/PUT /horse_statuses/1.json
  def update
    respond_to do |format|
      if @horse_status.update(horse_status_params)
        format.html { redirect_to horse_statuses_url, notice: 'Horse status was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @horse_status }
      else
        format.html { render action: 'edit' }
        format.json { render json: @horse_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /horse_statuses/1
  # DELETE /horse_statuses/1.json
  def destroy
    @horse_status.destroy
    respond_to do |format|
      format.html { redirect_to horse_statuses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_horse_status
      @horse_status = HorseStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def horse_status_params
      params.require(:horse_status).permit(:horse_id, :status_id, :value)
    end
end
