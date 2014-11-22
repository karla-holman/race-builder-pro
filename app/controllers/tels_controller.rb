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

    if @race_ids.any?
      @alternates = Race.where('id not in (?)', @race_ids)
    else
      @alternates = Race.all
    end
  end

  def new
    @tel = Tel.new
    @week = Week.find(tel_params[:week_id])
  end

  def edit
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
    @tel.update(tel_params)
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
    @race.day_id = ''
    @race.save
  end

  private
    def set_tel
      @tel = Tel.find(params[:id])
    end

    def tel_params
      params.require(:tel).permit(:week_id, :num_races, :date, :race_id, :tel_id)
    end
end
