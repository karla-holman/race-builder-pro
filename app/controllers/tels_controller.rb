class TelsController < ApplicationController
  before_action :set_tel, only: [:show, :edit, :update, :destroy, :reset_races]

  # GET /tels
  # GET /tels.json
  def index
    @tels = Tel.all
  end

  # GET /tels/1
  # GET /tels/1.json
  def show
    @races = Race.all
    @meet = Meet.find(@tel.meet_id)
  end

  # GET /tels/new
  def new
    @tel = Tel.new()
    @meet = Meet.find(tel_params[:meet_id])
  end

  # GET /tels/1/edit
  def edit
    @meet = Meet.find(tel_params[:meet_id])
  end

  # POST /tels
  # POST /tels.json
  def create
    @tel = Tel.new(tel_params)
    @meet = Meet.find(tel_params[:meet_id])

    respond_to do |format|
      if @tel.save
        format.html { redirect_to @meet, notice: 'Tel was successfully created.' }
      end
    end
  end

  # PATCH/PUT /tels/1
  # PATCH/PUT /tels/1.json
  def update
    respond_to do |format|
      if @tel.update(tel_params)
        format.html { redirect_to @tel, notice: 'Tel was successfully updated.' }
        format.json { render :show, status: :ok, location: @tel }
      else
        format.html { render :edit }
        format.json { render json: @tel.errors, status: :unprocessable_entity }
      end
    end
  end

  def reset_races
    @tel.days.each do |day|
      day.races.each do |race|
        race.horseraces.delete_all
      end
    end

    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  # DELETE /tels/1
  # DELETE /tels/1.json
  def destroy
    @tel.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tel
      @tel = Tel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tel_params
      params.require(:tel).permit(:tel_id, :meet_id, :start_date, :end_date, :published, :closed)
    end
end
