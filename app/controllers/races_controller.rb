class RacesController < ApplicationController
  before_action :set_race, only: [:show, :edit, :update, :destroy, :racefinish]

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
    @categories = Category.all - Category.where(:datatype => "Bool")
    
    if @race.race_type == 'Stakes'
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

    @horse_ids = Array.new()
    possible_horses.each do |horse|
      @horse_ids.push(horse.id)
      @genderFlag = "unset"
      @race.conditions.each do |condition|
        category = condition.category
        case category.name
        when 'Age'
          specific_value  = age(horse.DOB.to_date)
          success = filter_range(condition, specific_value)
        when 'Wins'
          specific_value = horse.firsts
          success = filter_range(condition, specific_value)
        when 'Gender'
          success = "yes"
          if condition.value == horse.gender
            @genderFlag = "yes"
          elsif @genderFlag != "yes"
            @genderFlag = "no"
          end 
        when 'Bred'
          if condition.value == horse.POB
            success = "yes"
          else
            success = "no"
          end 
        when 'Hasn\'t Won Since'
          if horse.last_win
            if condition.value.to_i > horse.last_win.year
              success = "yes"
            else
              success = "no"
            end
          else
            success = "yes"
          end
        end
        if success != "yes"
          @horse_ids.pop
          break
        end 
      end
      if @genderFlag != "yes" && @genderFlag != "unset"
        @horse_ids.pop
      end
    end
    if @horse_ids.any?
      @eligible = Horse.where("id IN (?)", @horse_ids)
    end

    if @race.race_type == 'Stakes'
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
    if current_user.admin?
      @horses = Horse.all
    elsif current_user.trainer?
      @horses = Horse.where(:trainer_id => current_user.id)
    else
      @horses = Horse.where(:owner_id => current_user.id)
    end
    if params[:horse_id]
      @horse = Horse.find(params[:horse_id])
    end
  end

  def schedule
    @races = Race.where("race_type = (?) OR race_type = (?)", "Protocol", "Stakes")
    @today = Date.today
    if current_user.admin?
      @horses = Horse.all
    elsif current_user.trainer?
      @horses = Horse.where(:trainer_id => current_user.id)
    else
      @horses = Horse.where(:owner_id => current_user.id)
    end 
  end

  def stakes
    @races = Race.where(:race_type => "Stakes")
    @today = Date.today
    if current_user.admin?
      @horses = Horse.all
    elsif current_user.trainer?
      @horses = Horse.where(:trainer_id => current_user.id)
    else
      @horses = Horse.where(:owner_id => current_user.id)
    end
  end

  def raceList
    if !params[:age_id].blank?
      @age = Condition.find(params[:age_id])
    end
    if !params[:wins_id].blank?
      @wins = Condition.find(params[:wins_id])
    end
    if !params[:gender_id].blank?
      @gender = Condition.find(params[:gender_id])
    end
    if !params[:lower_claiming].blank?
      @lower_claiming = params[:lower_claiming]
    end
    if !params[:upper_claiming].blank?
      @upper_claiming = params[:upper_claiming]
    end
    if !params[:noWinsSince_id].blank?
      @noWinsSince = Condition.find(params[:noWinsSince_id])
    end
    if !params[:distance].blank?
      @distance = params[:distance]
    end

    @horse = Horse.find(params[:horse_id])
    @race_ids = Array.new()
    @claiming_levels = Array.new()
    
    Race.all.each do |race|
      @race_ids.push(race.id)
      if race.claiming_level
        if !@claiming_levels.include? race.claiming_level
          @claiming_levels.push(race.claiming_level)
        end
      end
      @remove = "no"
      @ageCheck = "false"
      @winsCheck = "false"
      @genderCheck = "false"
      @noWinsSinceCheck = "false"
      @genderFLAG = "unset"
      @genderCON = "unset"
      if race.conditions
        race.conditions.each do |condition|
          category = condition.category
          case category.name
          when 'Age'
            @ageCheck = "true"
            horseAge  = age(@horse.DOB.to_date)
            valid = filter_range(condition, horseAge)
            if valid == "no"
                puts "REMOVE AGE NOT VALID"
                @remove = "yes"
            elsif @age
              if @age != condition
                @remove = "yes"
                puts "REMOVE AGE NOT CONDITION"
              end           
            end
          when 'Wins'
            @winsCheck = "true"
            horseWins = @horse.firsts
            valid = filter_range(condition, horseWins)
            if valid == "no"
              @remove = "yes"
              puts "REMOVE WINS NOT VALID"
            elsif @wins
              if @wins != condition
                @remove = "yes"
                puts "REMOVE WINS NOT CONDITION"
              end
            end
          when 'Gender'
            @genderCheck = "true"
            if @gender
              if @gender == condition
                @genderCON = "false"
              elsif @gender != condition && @genderCON != "false"
                @genderCON = "true"
              end
              if @horse.gender == condition.value
                @genderFLAG = "false"
              elsif @horse.gender != condition.value && @genderFLAG != "false"
                @genderFLAG = "true"
              end
            else
              if @horse.gender == condition.value
                @genderFLAG = "false"
              elsif @horse.gender != condition.value && @genderFLAG != "false"
                @genderFLAG = "true"
              end
            end
          when 'Bred'
            if condition.value == @horse.POB
              @remove = "yes"
            end 
          when 'Hasn\'t Won Since'
            @noWinsSinceCheck = "true"
            if @horse.last_win
              if condition.value.to_i > @horse.last_win.year
                @remove = "yes"
              elsif @noWinsSince
                if @noWinsSince != condition
                  @remove = "yes"
                end
              end
            end
          end
        end
        check = "check"
        if @wins && check == "check"
          if @winsCheck == "false"
            @race_ids.pop
            check = "skip"
          else
            check = "check"
          end
        end
        if @age && check == "check"
          if @ageCheck == "false"
            @race_ids.pop
            check = "skip"
          else
            check = "check"
          end
        end
        if @gender && check == "check"
          if @genderCheck == "false"
            @race_ids.pop
            check = "skip"
          elsif @genderFLAG == "true" || @genderCON == "true"
            @race_ids.pop
            check = "skip"
          else
            check = "check"
          end
        end
        if @distance && check == "check"
          if @distance == "Long" && race.distance_type != "Miles"
            @race_ids.pop
            check = "skip"
          elsif @distance == "Short" && race.distance_type != "Furlongs"
            @race_ids.pop
            check = "skip"
          else
            check = "check"
          end
        end
        if check == "check"
          if @remove == "yes"
            @race_ids.pop
          elsif @genderFLAG == "true"
            @race_ids.pop
          elsif @noWinsSince
            if @noWinsSinceCheck == "false"
              @race_ids.pop
            end
          else
            if @lower_claiming && @upper_claiming
              if (@lower_claiming.to_f > race.claiming_level) || (@upper_claiming.to_f < race.claiming_level)
                @race_ids.pop
              end
            elsif @lower_claiming
              if (@lower_claiming.to_f > race.claiming_level)
                @race_ids.pop
              end
            elsif @upper_claiming
              if (@upper_claiming.to_f < race.claiming_level)
                @race_ids.pop
              end
            end
          end
        end
      elsif @lower_claiming && @upper_claiming
        if (@lower_claiming.to_f > race.claiming_level) || (@upper_claiming.to_f < race.claiming_level)
          @race_ids.pop
        end
      elsif @lower_claiming
        if (@lower_claiming.to_f > race.claiming_level)
          @race_ids.pop
        end
      elsif @upper_claiming
        if (@upper_claiming.to_f < race.claiming_level)
          @race_ids.pop
        end
      elsif @distance
        if @distance == "Long" && race.distance_type != "Miles"
          @race_ids.pop
        elsif @distance == "Short" && race.distance_type != "Furlongs"
          @race_ids.pop
        end
      elsif (@age || @wins || @gender || @noWinsSince)
        @race_ids.pop
      end
    end

    if @race_ids.any?
      @races = Race.where("id IN (?) AND race_type = 'Alternate'", @race_ids)
    end

    @ageList = Condition.where(:category_id => Category.find_by_name("Age"))
    @genderList = Condition.where(:category_id => Category.find_by_name("Gender"))
    @winList = Condition.where(:category_id => Category.find_by_name("Wins"))
    @noWinsSinceList = Condition.where(:category_id => Category.find_by_name("Hasn't Won Since"))
    @claiming_levels.sort!

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

  # DELETE /races/1
  # DELETE /races/1.json
  def destroy
    @race.destroy
    respond_to do |format|
      @race.create_activity :destroy, owner: current_user
      format.html { redirect_to races_url }
      format.json { head :no_content }
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race
      @race = Race.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def race_params
      params.require(:race).permit(:name, :created_at, :updated_at, :race_number, :description, :race_datetime, :winner, :claiming_purse, :status, :send_id, :recv_id, :race_id, :horse_id, :action, :claiming_level, :upper_claiming, :lower_claiming,:age_id, :wins, :distance, :condition_ids => [])
    end
end
