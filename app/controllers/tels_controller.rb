class TelsController < ApplicationController
  before_action :set_tel, only: [:show, :edit, :update, :destroy, :friday, :saturday, :sunday]

  # GET /tels
  # GET /tels.json
  def index
    @tels = Tel.all
  end

  def friday
    get_weekend(@tel.weekend_start)

    @tel_races = @tel.races.where("race_datetime <= (?) AND race_datetime >= (?)", @friday.end_of_day, @friday.beginning_of_day)
    tel_ids = @tel_races.pluck(:id)
    
    if tel_ids.empty?
      @alternates = Race.where("race_datetime <= (?) AND race_datetime >= (?)", @friday.end_of_day, @friday.beginning_of_day)
    else
      @alternates = Race.where("race_datetime <= (?) AND race_datetime >= (?) AND id not IN (?)", @friday.end_of_day, @friday.beginning_of_day, tel_ids)
    end

    @meet = Meet.find(@tel.meet_id)
    @day = "Friday"
    render "day"
  end

  def saturday
    get_weekend(@tel.weekend_start)

    @tel_races = @tel.races.where("race_datetime <= (?) AND race_datetime >= (?)", @saturday.end_of_day, @saturday.beginning_of_day)
    tel_ids = @tel_races.pluck(:id)
    
    if tel_ids.empty?
      @alternates = Race.where("race_datetime <= (?) AND race_datetime >= (?)", @saturday.end_of_day, @saturday.beginning_of_day)
    else
      @alternates = Race.where("race_datetime <= (?) AND race_datetime >= (?) AND id not IN (?)", @saturday.end_of_day, @saturday.beginning_of_day, tel_ids)
    end

    @meet = Meet.find(@tel.meet_id)
    @day = "Saturday"
    render "day"
  end

  def sunday
    get_weekend(@tel.weekend_start)

    @tel_races = @tel.races.where("race_datetime <= (?) AND race_datetime >= (?)", @sunday.end_of_day, @sunday.beginning_of_day)
    tel_ids = @tel_races.pluck(:id)

    if tel_ids.empty?
      @alternates = Race.where("race_datetime <= (?) AND race_datetime >= (?)", @sunday.end_of_day, @sunday.beginning_of_day)
    else
      @alternates = Race.where("race_datetime <= (?) AND race_datetime >= (?) AND id not IN (?)", @sunday.end_of_day, @sunday.beginning_of_day, tel_ids)
    end
    
    @meet = Meet.find(@tel.meet_id)
    @day = "Sunday"
    render "day"
  end

  # GET /tels/1
  # GET /tels/1.json
  def show
    get_weekend(@tel.weekend_start)
    @races = Race.where("race_datetime <= ? AND race_datetime >= ?", @sunday.end_of_day, @friday.beginning_of_day)
    @meet = Meet.find(@tel.meet_id)
  end

  # GET /tels/new
  def new
    @tel = Tel.new()
    @meet = Meet.find(tel_params[:meet_id])
  end

  def add_race
    @race = Race.find(tel_params[:race_id])
    @race.tel_id = tel_params[:tel_id]
    @race.save
  end

  def remove_race
    @race = Race.find(tel_params[:race_id])
    @race.tel_id = ''
    @race.save
  end

  # GET /tels/1/edit
  def edit
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

  # DELETE /tels/1
  # DELETE /tels/1.json
  def destroy
    @tel.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  def get_weekend(start)
    @friday = start
    @saturday = @friday.tomorrow
    @sunday = @saturday.tomorrow
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tel
      @tel = Tel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tel_params
      params.require(:tel).permit(:race_id, :tel_id, :meet_id, :weekend_start)
    end
end
