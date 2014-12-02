class TelsController < ApplicationController
  before_action :set_tel, only: [:show, :edit, :update, :destroy]
  skip_before_filter  :verify_authenticity_token

  def index
    @tels = Tel.all
  end

  def show
    @meet = @tel.week.meet
    @week = @tel.week
    @race_ids = []
    @week.tels.each do |tel|
      tel.races.each do |race|
        @race_ids.push(race.id)
      end
    end

    @purse_total = 0
    num_races = 0
    @average_field_size = 0

    @tel.races.each do |race|
      @purse_total += race.purse
      if race.field_size
        @average_field_size += race.field_size
        num_races = num_races + 1
      end
    end

    if num_races > 0
      @average_field_size = @average_field_size/num_races
    end

    eligible_races = FilterRacesService.new.currentEligibleRaces()
    if @race_ids.any?
      @alternates = Race.where('id not in (?)', @race_ids) & eligible_races
    else
      @alternates = Race.all
    end
  end

  def new
    @tel = Tel.new
    @week = Week.find(tel_params[:week_id])
  end

  def edit
    @week = @tel.week
  end

  def create
    @tel = Tel.new(tel_params)
    @week = Week.find(tel_params[:week_id])

    respond_to do |format|
      if @tel.save
        format.html { redirect_to @week, notice: 'Day was successfully created.' }
      end
    end
  end

  def update
    respond_to do |format|
      if @tel.update(tel_params)
        format.html { redirect_to @tel, notice: 'Meet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tel }
      else
        format.html { render :edit }
        format.json { render json: @tel.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tel.destroy
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

  private
    def set_tel
      @tel = Tel.find(params[:id])
    end

    def tel_params
      params.require(:tel).permit(:week_id, :num_races, :date, :race_id, :tel_id, :published, :entry_list)
    end
end
