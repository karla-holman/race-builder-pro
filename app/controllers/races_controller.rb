class RacesController < ApplicationController
  before_action :set_race, only: [:show, :edit, :update, :destroy, :racefinish, :duplicate_race]
  skip_before_filter  :verify_authenticity_token

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
    @categories = []
    @race.conditions.each do |condition|
      @categories.push(Category.find(condition.category_id))
    end
    @categories.uniq
    
    if @race.category == 'Priority' && @race.stakes && @race.needs_nomination
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

    inactive = Status.find_by_name('Inactive')
    vets = Status.find_by_name('Vet\'s List')
    steward = Status.find_by_name('Steward\'s List')

    @eligible = Array.new()
    possible_horses.each do |horse|
      if @race.isHorseEligible(horse) && horse.status != inactive && horse.status != vets && horse.status != steward
        @eligible.push(horse)
      end
    end

    if @race.category == 'Priority' && @race.stakes && @race.needs_nomination
      @race_groups = [["Confirmed", @confirmed], ["Pending", @pending], ["Denied", @denied], ["Eligible", @eligible]]
    else
      @race_groups = [["Confirmed", @confirmed], ["Interested", @interested], ["Eligible", @eligible]]
    end
  end

  # GET /races/new
  def new
    @race = Race.new
    @claiming_one = ClaimingPrice.new
    @claiming_two = ClaimingPrice.new
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
    eligible_races = FilterRacesService.new.currentEligibleRaces()
    @races = Race.where(:category => 'Priority') & eligible_races
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
    eligible_races = FilterRacesService.new.currentEligibleRaces()
    @races = Race.where("category = (?) AND stakes = (?)", "Priority", true) & eligible_races

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
    if !params[:bred_id].blank?
      @bred = Condition.find(params[:bred_id])
      @races = FilterRacesService.new.conditionFilter(@races, @bred)
    end
    if !params[:sex].blank?
      @sex = params[:sex]
      @races = FilterRacesService.new.sexFilter(@races, @sex)
    end
    if !params[:distance].blank?
      @distance = params[:distance]
      @races = FilterRacesService.new.distanceFilter(@races, @distance)
    end
    if !params[:lower_claiming].blank?
      @lower_claiming = params[:lower_claiming]
      @races = FilterRacesService.new.lowerClaimingFilter(@races, @lower_claiming)
    end
    if !params[:upper_claiming].blank?
      @upper_claiming =  params[:upper_claiming]
      @races = FilterRacesService.new.upperClaimingFilter(@races, @upper_claiming)
    end

     @ageList = FilterRacesService.new.ageCategories(@horse)
     @winList = FilterRacesService.new.winCategories(@horse)
     @bredList = FilterRacesService.new.bredCategories(@horse)
     @claiming_prices = ClaimingPrice.all.pluck(:price).reject(&:blank?).uniq.sort

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
    @race_date = @race.race_date
    if(@race.claiming_prices[0])
      @claiming_one = @race.claiming_prices[0]
    else
      @claiming_one = ClaimingPrice.new
    end

    if(@race.claiming_prices[1])
      @claiming_two = @race.claiming_prices[1]
    else
      @claiming_two = ClaimingPrice.new
    end

    if(@race.condition_node.nil?)
      root = ConditionNode.new
      root.setAsRoot
      root.value = @race.id
      root.save
      @race.condition_node = root
      @race.save
    end
  end

  # POST /races
  # POST /races.json
  def create
    @race = Race.new(race_params)
    if(params[:race_date])
      @race_date = RaceDate.new
      @race_date.race_id = @race.id         
      @race_date.date = params[:race_date][:date]
      @race_date.save
      @race.race_date = @race_date
    end
    if(params[:category])
      @race.category = 'Priority'
    else
      @race.category = 'Alternate'
    end
    respond_to do |format|
      if @race.save
        if(params[:claiming_one])
          if(@race.claiming_prices[0])
            @race.claiming_prices[0].price = params[:claiming_one]
            @race.claiming_prices[0].save
          else
            @claiming_one = ClaimingPrice.new
            @claiming_one.race_id = @race.id
            @claiming_one.price = params[:claiming_one]
            @claiming_one.save
            @race.claiming_prices[0] = @claiming_one
          end
        end
        if (params[:claiming_two])
          if(@race.claiming_prices[1])
            @race.claiming_prices[1].price = params[:claiming_two]
            @race.claiming_prices[1].save
          else
            @claiming_two = ClaimingPrice.new
            @claiming_two.race_id = @race.id
            @claiming_two.price = params[:claiming_two]
            @claiming_two.save
            @race.claiming_prices[1] = @claiming_two
          end
        end
        @race.save
        if(params[:commit] == 'Save and Duplicate')
          new_race = @race.dup
          new_race.conditions = @race.conditions
          new_race.save
          if(params[:claiming_one])
            @claiming_one = ClaimingPrice.new
            @claiming_one.race_id = new_race.id
            @claiming_one.price = params[:claiming_one]
            @claiming_one.save
            new_race.claiming_prices[0] = @claiming_one
          end
          if (params[:claiming_two])
            @claiming_two = ClaimingPrice.new
            @claiming_two.race_id = new_race.id
            @claiming_two.price = params[:claiming_two]
            @claiming_two.save
            new_race.claiming_prices[1] = @claiming_two
          end
          new_race.save
          @race.create_activity :create, owner: current_user
          format.html { redirect_to edit_race_path(@race) }
        else
          @race.create_activity :create, owner: current_user
          format.html { redirect_to races_url, notice: 'Race was successfully created.' }
          format.json { render action: 'index', status: :created, location: @races }
        end
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
      if(params[:race_date])
        if !@race.race_date
          @race_date = RaceDate.new
          @race_date.race_id = @race.id         
        else
          @race_date = @race.race_date
        end
        @race_date.date = params[:race_date][:date]
        @race_date.save
        @race.race_date = @race_date
      end
      if(params[:category])
        @race.category = 'Priority'
      else
        @race.category = 'Alternate'
      end
      respond_to do |format|
        if @race.update(race_params)
          if(params[:claiming_one])
            if(@race.claiming_prices[0])
              @race.claiming_prices[0].price = params[:claiming_one]
              @race.claiming_prices[0].save
            else
              @claiming_one = ClaimingPrice.new
              @claiming_one.race_id = @race.id
              @claiming_one.price = params[:claiming_one]
              @claiming_one.save
              @race.claiming_prices[0] = @claiming_one
            end
          end
          if (params[:claiming_two])
            if(@race.claiming_prices[1])
              @race.claiming_prices[1].price = params[:claiming_two]
              @race.claiming_prices[1].save
            else
              @claiming_two = ClaimingPrice.new
              @claiming_two.race_id = @race.id
              @claiming_two.price = params[:claiming_two]
              @claiming_two.save
              @race.claiming_prices[1] = @claiming_two
            end
          end
          @race.save
          if(params[:commit] == 'Save and Duplicate')
            new_race = @race.dup
            new_race.conditions = @race.conditions
            new_race.claiming_prices = @race.claiming_prices
            new_race.save
            if(params[:claiming_one])
              @claiming_one = ClaimingPrice.new
              @claiming_one.race_id = new_race.id
              @claiming_one.price = params[:claiming_one]
              @claiming_one.save
              new_race.claiming_prices[0] = @claiming_one
            end
            if (params[:claiming_two])
              @claiming_two = ClaimingPrice.new
              @claiming_two.race_id = new_race.id
              @claiming_two.price = params[:claiming_two]
              @claiming_two.save
              new_race.claiming_prices[1] = @claiming_two
            end
            new_race.save
            @race.create_activity :update, owner: current_user
            format.html { redirect_to :back }
          else
            @race.create_activity :update, owner: current_user
            format.html { redirect_to races_url, notice: 'Race was successfully updated.' }
            format.json { render action: 'index', status: :ok, location: @races }
          end
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

    if new_winner.race.tel
      date = new_winner.race.tel.date
    else
      date = Date.today
    end

    new_winner.date = date
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
    new_race.conditions = @race.conditions
    new_race.save
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  # DELETE /races/1
  # DELETE /races/1.json
  def destroy
    @race.create_activity :destroy, parameters: {name: @race.name}, owner: current_user
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
      params.require(:race).permit(:name, :created_at, :updated_at, :race_number, :description, :weights, :race_datetime, :winner, :claiming_purse, :status, :send_id, :recv_id, :race_id, :horse_id, :action, :claiming_level, :upper_claiming, :lower_claiming,:age_id, :wins, :distance, :category, :distance_type, :field_size, :purse, :race_type, :stakes, :needs_nomination, :condition_ids => [])
    end
end
