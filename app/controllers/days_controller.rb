class DaysController < ApplicationController
  before_action :set_day, only: [:show, :edit, :update, :destroy]
  skip_before_filter  :verify_authenticity_token

  def index
    @days = Day.all
  end

  def show
    @meet = @day.tel.meet
    @tel = @day.tel
    @race_ids = []
    @tel.days.each do |day|
      day.races.each do |race|
        @race_ids.push(race.id)
      end 
    end

    if @race_ids.any?
      @alternates = Race.where('id not in (?)', @race_ids)
    else
      @alternates = Race.all
    end
  end

  def new
    @day = Day.new()
    @tel = Tel.find(day_params[:tel_id])
  end

  def edit
  end

  def create
    @day = Day.new(day_params)
    @tel = Tel.find(day_params[:tel_id])

    respond_to do |format|
      if @day.save
        format.html { redirect_to @tel, notice: 'Day was successfully created.' }
      end
    end
  end

  def update
    @day.update(day_params)
  end

  def destroy
    @day.destroy
  end

  def add_race
    @race = Race.find(day_params[:race_id])
    @race.day_id = day_params[:day_id]
    @race.save
  end

  def remove_race
    @race = Race.find(day_params[:race_id])
    @race.day_id = ''
    @race.save
  end

  private
    def set_day
      @day = Day.find(params[:id])
    end

    def day_params
      params.require(:day).permit(:tel_id, :field_size, :date, :race_id, :day_id)
    end
end
