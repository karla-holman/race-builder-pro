class RacesController < ApplicationController
  before_action :set_race, only: [:show, :edit, :update, :destroy, :racefinish, :duplicate_race]

  # GET /races
  # GET /races.json
  def index
    if params[:search]
      @races = Race.search(params[:search]).order("name ASC") 
    else current_user.admin?
      @races = Race.all
    end
  end

  def racefinish
    confirmed_ids = Horserace.where("race_id = (?) AND (status = (?) OR status = (?))", @race.id, "Confirmed", "Scratched").pluck(:horse_id)
    @confirmed = Horse.where("id IN (?)", confirmed_ids)
    @trainers = User.where(:role => 1)
    @owners = User.where(:role => 0)
  end

  # GET /races/1
  # GET /races/1.json
  def show
    confirmed_ids = Horserace.where("race_id = (?) AND (status = (?) OR status = (?))", @race.id, "Confirmed", "Scratched").pluck(:horse_id)
    interested_ids = Horserace.where(:race_id => @race.id, :status => "Interested").pluck(:horse_id)
    denied_ids = Horserace.where(:race_id => @race.id, :status => "Denied").pluck(:horse_id)
    pending_ids = Notification.where(:action => "Nominate", :send_id => @race.id).pluck(:recv_id)
    @confirmed = Horse.where("id IN (?)", confirmed_ids)
    @interested = Horse.where("id IN (?)", interested_ids)
    @denied = Horse.where("id IN (?)", denied_ids)
    @pending = Horse.where("id IN (?)", pending_ids)
    @categories = Category.all
    
    if @race.type == 'Stakes'
      possible_horses = Horse.all
      if !@confirmed.empty?
        possible_horses = possible_horses.where("id not IN (?)", confirmed_ids)
      end
      if !@pending.empty?
        possible_horses = possible_horses.where("id not IN (?)", pending_ids)
      end
      if !@denied.empty?
        possible_horses = possible_horses.where("id not IN (?)", denied_ids)
      end
    else
      if @confirmed.empty? && @interested.empty?
        possible_horses = Horse.all
      elsif @confirmed.empty?
        possible_horses = Horse.where("id not IN (?)", interested_ids)
      elsif @interested.empty?
        possible_horses = Horse.where("id not IN (?)", confirmed_ids)
      else
        possible_horses = Horse.where("id not IN (?) and id not IN (?)", confirmed_ids, interested_ids)
      end
    end
    @inactive = Status.find_by_name('Inactive')
    @eligible = Array.new()
    possible_horses.each do |horse|
      @races = FilterRacesService.new.horseFilter(horse) 
      if @races.include?(@race) && horse.status != @inactive
        @eligible.push(horse)
      end
    end

    if @race.type == 'Stakes'
      @race_groups = [["Confirmed", @confirmed], ["Pending", @pending], ["Denied", @denied], ["Eligible", @eligible]]
    else
      @race_groups = [["Confirmed", @confirmed], ["Interested", @interested], ["Eligible", @eligible]]
    end
  end

  # GET /races/new
  def new
    @race = Race.new
  end

  def menu
    @inactive = Status.find_by_name('Inactive')
    if current_user.admin?
      @horses = Horse.all
    elsif current_user.trainer?
      @horses = Horse.where(:trainer_id => current_user.id).where.not(:status => @inactive)
    else
      @horses = Horse.where(:owner_id => current_user.id).where.not(:status => @inactive)
    end
    if params[:horse_id]
      @horse = Horse.find(params[:horse_id])
    end
  end

  def schedule
    @inactive = Status.find_by_name('Inactive')
    @races = Race.where("category = (?) OR category = (?)", "Protocol", "Stakes")
    @today = Date.today
    if current_user.admin?
      @horses = Horse.all
    elsif current_user.trainer?
      @horses = Horse.where(:trainer_id => current_user.id).where.not(:status => @inactive)
    else
      @horses = Horse.where(:owner_id => current_user.id).where.not(:status => @inactive)
    end 
  end

  def stakes
    @inactive = Status.find_by_name('Inactive')
    @races = Race.where(:category => "Stakes")
    @today = Date.today
    if current_user.admin?
      @horses = Horse.all
    elsif current_user.trainer?
      @horses = Horse.where(:trainer_id => current_user.id).where.not(:status => @inactive)
    else
      @horses = Horse.where(:owner_id => current_user.id).where.not(:status => @inactive)
    end
  end

  def raceList
    @horse = Horse.find(params[:horse_id])
    @races = FilterRacesService.new.horseFilter(@horse)

    if !params[:age_id].blank?
      @age = Condition.find(params[:age_id])
      @races = FilterRacesService.new.conditionFilter(@races, @age)
    end
    if !params[:wins_id].blank?
      @wins = Condition.find(params[:wins_id])
      @races = FilterRacesService.new.conditionFilter(@races, @wins)
    end
    if !params[:gender_id].blank?
      @gender = Condition.find(params[:gender_id])
      @races = FilterRacesService.new.genderFilter(@races, @gender)
    end
    if !params[:noWinsSince_id].blank?
      @noWinsSince = Condition.find(params[:noWinsSince_id])
      @races = FilterRacesService.new.conditionFilter(@races, @noWinsSince)
    end
    if !params[:distance].blank?
      @distance = params[:distance]
      @races = FilterRacesService.new.distanceFilter(@races, @distance)
    end
    if !params[:lower_purse].blank?
      @lower_purse = params[:lower_purse]
      @races = FilterRacesService.new.lowerPurseFilter(@races, @lower_purse)
    end
    if !params[:upper_purse].blank?
      @upper_purse =  params[:upper_purse]
      @races = FilterRacesService.new.upperPurseFilter(@races, @upper_purse)
    end

     @ageList = Condition.where(:category_id => Category.find_by_name("Age"))
     @genderList = Condition.where(:category_id => Category.find_by_name("Gender"))
     @winList = Condition.where(:category_id => Category.find_by_name("Wins"))
     @noWinsSinceList = Condition.where(:category_id => Category.find_by_name("Hasn't Won Since"))
     @purses = Race.all.pluck(:purse).uniq.sort

     confirmed_race = Horserace.where(:horse_id => @horse.id, :status => "Confirmed")

     if confirmed_race.any?
       @confirmed = true
     end

    respond_to do |format|
      format.js
    end
  end

  # GET /races/1/edit
  def edit
  end

  # POST /races
  # POST /races.json
  def create
    @race = Race.new(race_params)

    respond_to do |format|
      if @race.save
        @race.create_activity :create, owner: current_user
        format.html { redirect_to races_url, notice: 'Race was successfully created.' }
        format.json { render action: 'index', status: :created, location: @races }
      else
        format.html { render action: 'new' }
        format.json { render json: @race.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /races/1
  # PATCH/PUT /races/1.json
  def update
    if params[:condition_ids]
      current_conditions = RaceCondition.where(:race => @race)
      params[:condition_ids].each do |condition|
      RaceCondition.find_or_create_by!(condition_id: condition, race_id: @race.id)
      end
      current_conditions.each do |condition|
        found = params[:condition_ids].find(condition.id)
        if found
        else
          condition.destroy
        end
      end
    else
      respond_to do |format|
        if @race.update(race_params)
          @race.create_activity :update, owner: current_user
          format.html { redirect_to races_url, notice: 'Race was successfully updated.' }
          format.json { render action: 'index', status: :ok, location: @races }
        else
          format.html { render action: 'edit' }
          format.json { render json: @race.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update_status
    race = Race.find(params[:id])
    race.status = params[:status]
    race.save

    respond_to do |format|
      format.html { redirect_to :back, notice: 'Race was successfully updated.' }
    end
  end

  def add_winner
    new_winner = RaceWinner.new(:race_id => params[:race_id], :horse_id => params[:horse_id])
    new_winner.save

    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  def scratch_horse
    horse_race = Horserace.where(:race_id => params[:race_id], :horse_id => params[:horse_id])
    horse_race[0].status = 'Scratched'
    horse_race[0].save

    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  def duplicate_race
    new_race = @race.dup
    new_race.save

    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  # DELETE /races/1
  # DELETE /races/1.json
  def destroy
    @hrace.create_activity :destroy, parameters: {name: @race.name}, owner: current_user
    @race.destroy
    respond_to do |format|
      format.html { redirect_to races_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race
      @race = Race.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def race_params
      params.require(:race).permit(:name, :created_at, :updated_at, :race_number, :description, :race_datetime, :winner, :claiming_purse, :status, :send_id, :recv_id, :race_id, :horse_id, :action, :claiming_level, :upper_claiming, :lower_claiming,:age_id, :wins, :distance, :category, :distance_type, :condition_ids => [])
    end
end
