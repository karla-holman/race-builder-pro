class TelsController < ApplicationController
  before_action :set_tel, only: [:show, :edit, :update, :destroy, :returnRacesToDatabase]
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
          priority_races = @tel.races.where(:category => "Priority")

          priority_array = Array.new
          priority_races.each do |race|
            priority_array.push({'Race' => race, 'Confirmed' => race.confirmed_count, 'Interested' => race.interested_count})
          end

          priority_array = priority_array.sort_by {|x| [-x['Confirmed'], -x['Interested']] }
          
          nonpriority_races = @tel.races.where.not(:category => "Priority")
          nonpriority_array = Array.new
          nonpriority_races.each do |race|
            nonpriority_array.push({'Race' => race, 'Confirmed' => race.confirmed_count, 'Interested' => race.interested_count})
          end

          nonpriority_array = nonpriority_array.sort_by {|x| [-x['Confirmed'], -x['Interested']] }
          races_array = priority_array + nonpriority_array

          if races_array.length > @tel.num_races
            delete_races = races_array.slice(@tel.num_races, races_array.length - @tel.num_races)

            delete_races.each do |raceHash|
              race = raceHash['Race']
              race.tel = nil
              race.save
            end
          end

          running = Status.find_by_name('Running')
          @tel.races.each do |race|
            if race.category != 'Priority'
              race.duplicateRace
            end
            
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
      if !race_date.race.nil? && race_date.race.status == "Published"
        race_date.race.tel = tel
        race_date.race.save
      end
    end
  end

  def returnRacesToDatabase
    @tel.races.each do |race|
      race.tel = nil
      race.save
    end

    respond_to do |format|
      format.html { redirect_to :back }
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
