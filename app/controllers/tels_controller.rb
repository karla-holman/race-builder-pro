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
    @tel.week = @week
  end

  def edit
    @week = @tel.week
  end

  def create
    @tel = Tel.new(tel_params)
    @week = Week.find(tel_params[:week_id])

    respond_to do |format|
      if @tel.save
        addRaces(@tel)
        format.html { redirect_to @week, notice: 'Tel was successfully created.' }
      end
    end
  end

  def update
    @week = Week.find(@tel.week_id)
    respond_to do |format|
      if @tel.update(tel_params)

        if tel_params[:entry_list] == 'true'
          running = Status.find_by_name('Running')
          @tel.races.each do |race|
            race.duplicateRace
            race.horses.each do |horse|
              horse.status = running
              horse.save
            end
          end
        end

        format.html { redirect_to @week, notice: 'Tel was successfully updated.' }
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

  def addRaces(tel)
    race_dates = RaceDate.where(:date => tel.date)
    race_dates.each do |race_date|
      if race_date.race.status == "Published"
        race_date.race.tel = tel
        race_date.race.save
      end
    end
  end

  private
    def set_tel
      @tel = Tel.find(params[:id])
    end

    def tel_params
      params.require(:tel).permit(:week_id, :num_races, :date, :race_id, :tel_id, :published, :entry_list, :entry_date)
    end
end
