class TelsController < ApplicationController
  before_action :set_tel, only: [:show, :edit, :update, :destroy]

  # GET /tels
  # GET /tels.json
  def index
    @tels = Tel.all
    get_weekend
    @races = Race.where("race_datetime <= (?) AND race_datetime >= (?)", @sunday.end_of_day, @friday.beginning_of_day)
  end

  def friday
    get_weekend
    @tels = Tel.where(:day => "Friday")
    tel_ids = @tels.pluck(:race_id)

    if tel_ids.any?
      @races = Race.where("race_datetime <= (?) AND race_datetime >= (?) AND id not IN (?)", @friday.end_of_day, @friday.beginning_of_day, tel_ids)
    else
      @races = Race.where("race_datetime <= (?) AND race_datetime >= (?)", @friday.end_of_day, @friday.beginning_of_day)
    end

    @day = "Friday"
    render "day"
  end

  def saturday
    get_weekend
    @tels = Tel.where(:day => "Saturday")
    tel_ids = @tels.pluck(:race_id)
    
    if tel_ids.any?
      @races = Race.where("race_datetime <= (?) AND race_datetime >= (?) AND id not IN (?)", @saturday.end_of_day, @saturday.beginning_of_day, tel_ids)
    else
      @races = Race.where("race_datetime <= (?) AND race_datetime >= (?)", @saturday.end_of_day, @saturday.beginning_of_day)
    end
    
    @day = "Saturday"
    render "day"
  end

  def sunday
    get_weekend
    @tels = Tel.where(:day => "Sunday")
    tel_ids = @tels.pluck(:race_id)

    if tel_ids.any?
      @races = Race.where("race_datetime <= (?) AND race_datetime >= (?) AND id not IN (?)", @sunday.end_of_day, @sunday.beginning_of_day, tel_ids)
    else
      @races = Race.where("race_datetime <= (?) AND race_datetime >= (?)", @sunday.end_of_day, @sunday.beginning_of_day)
    end

    @day = "Sunday"
    render "day"
  end

  # GET /tels/1
  # GET /tels/1.json
  def show
  end

  # GET /tels/new
  def new
    @race_id = tel_params[:race_id]
    @day = tel_params[:day]
    @tel = Tel.new
  end

  # GET /tels/1/edit
  def edit
  end

  # POST /tels
  # POST /tels.json
  def create
    @tel = Tel.new(tel_params)

    respond_to do |format|
      if @tel.save
        format.html { redirect_to @tel, notice: 'Tel was successfully created.' }
        format.json { render :show, status: :created, location: @tel }
      else
        format.html { render :new }
        format.json { render json: @tel.errors, status: :unprocessable_entity }
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

  def get_weekend
    @sunday = Date.today.sunday
    @saturday = @sunday.days_ago(1)
    @friday = @sunday.days_ago(2)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tel
      @tel = Tel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tel_params
      params.require(:tel).permit(:day, :race_id, :level, :section)
    end
end
