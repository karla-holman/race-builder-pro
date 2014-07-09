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
  end

  # GET /races/1
  # GET /races/1.json
  def show
    confirmed_ids = Horserace.where("race_id = (?) AND (status = (?) OR status = (?))", @race.id, "Confirmed", "Scratched").pluck(:horse_id)
    @confirmed = Horse.where("id IN (?)", confirmed_ids)
  
    @categories = Category.all - Category.where(:datatype => "Bool")
    @race_conditions = RaceCondition.where(:race => @race)
    interested_ids = Horserace.where(:race_id => @race.id, :status => "Interested").pluck(:horse_id)
    @interested = Horse.where("id IN (?)", interested_ids)
    
    if @confirmed.empty? && @interested.empty?
      possible_horses = Horse.all
    elsif @confirmed.empty?
      possible_horses = Horse.where("id not IN (?)", interested_ids)
    elsif @interested.empty?
      possible_horses = Horse.where("id not IN (?)", confirmed_ids)
    else
      possible_horses = Horse.where("id not IN (?) and id not IN (?)", confirmed_ids, interested_ids)
    end

    @horse_ids = Array.new()
    possible_horses.each do |horse|
      @horse_ids.push(horse.id)
      @race_conditions.each do |racecondition|
        condition = Condition.find(racecondition.condition_id)
        category = condition.category  
        case category.name
        when 'Age'
          specific_value  = age(horse.DOB.to_date)
          success = filter_range(condition, specific_value)
        when 'Wins'
          specific_value = horse.firsts
          success = filter_range(condition, specific_value)
        when 'Gender'
          if condition.value == horse.gender
            success = "yes"
          end 
        when 'Bred'
          if condition.value == horse.POB
            success = "yes"
          end 
        when 'Hasn\'t Won Since'
          if horse.last_win
            if condition.value.to_i > horse.last_win.year
              success = "yes"
            end
          end
        else
          success = "yes"
        end 
        if success != "yes"
          @horse_ids.pop
          break
        end
      end
    end
    if @horse_ids.any?
      @eligible = Horse.where("id IN (?)", @horse_ids)
    end
    @race_groups = [["Confirmed", @confirmed], ["Interested", @interested], ["Eligible", @eligible]]
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

  end

  def schedule
    @races = Race.where("race_type = (?) OR race_type = (?)", "Protocol", "Stakes")
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
    if current_user.admin?
      @horses = Horse.all
    elsif current_user.trainer?
      @horses = Horse.where(:trainer_id => current_user.id)
    else
      @horses = Horse.where(:owner_id => current_user.id)
    end
  end

  def raceList
    @horse = Horse.find(params[:horse_id])
    if params[:age_id].blank?
    else
      @age = Condition.find(params[:age_id])
    end
    if params[:win_id].blank?
    else
      @win = Condition.find(params[:win_id])
    end
    if params[:gender_id].blank?
    else
      @gender = Condition.find(params[:gender_id])
    end
    if params[:claiming_level].blank?
    else
      @claiming_level = params[:claiming_level]
    end

    @categories = Category.where(:datatype => "Bool")
    @statuses = Status.all
    @category = @categories.pluck(:id)
    @conditions = Condition.where("category_id IN (?)", @category)
    @current_status = HorseStatus.where(:horse => @horse).first
    @horse_conditions = @horse.conditions.pluck(:condition_id)
    @race_ids = Array.new()
    @claiming_levels = Array.new()
    
    Race.all.each do |race|
      bool_conditions = race.conditions.where("category_id IN (?)", @category).pluck(:condition_id)
      specific_conditions = race.conditions.pluck(:condition_id) - bool_conditions
      @race_ids.push(race.id)  
      if (race.claiming_level?)
        if @claiming_levels.include? race.claiming_level
        else
          @claiming_levels.push(race.claiming_level)
        end
      end
      if (specific_conditions.any?)
        specific_conditions.each do |specific_condition|
          if @claiming_level
            if @claiming_level != race.claiming_level
              race_ids.pop
              break
            end
          end
          condition = Condition.find(specific_condition)
          category = condition.category           
          case category.name
          when 'Age'
            if @age
              if @age == condition
                specific_value  = age(@horse.DOB.to_date)
                success = filter_range(condition, specific_value)
              end
            else
              specific_value  = age(@horse.DOB.to_date)
              success = filter_range(condition, specific_value)
            end
          when 'Wins'
            if @win
              if @win == condition
                  specific_value = @horse.firsts
                  success = filter_range(condition, specific_value)
                end
            else
              specific_value = @horse.firsts
              success = filter_range(condition, specific_value)
            end
          when 'Gender'
            if @gender
              if condition.value == @gender.value 
                success = "yes"
              end
            elsif condition.value == @horse.gender
              success = "yes"
            end 
          when 'Bred'
            if condition.value == @horse.POB
              success = "yes"
            end 
          when 'Hasn\'t Won Since'
            if @horse.last_win
              if condition.value.to_i > @horse.last_win.year
                success = "yes"
              end
            else
              success = "yes"
            end 
          end
          if success != "yes"
            @race_ids.pop
            break
          end        
        end
      elsif @age || @win || @gender
        @race_ids.pop
      elsif @claiming_level
        if @claiming_level != race.claiming_level
          @race_ids.pop
        end
      end
    end
    if @race_ids.any?
      @races = Race.where("id IN (?)", @race_ids)
    end

    ageId = Category.find_by_name("Age")
    winId = Category.find_by_name("Wins")
    genderID = Category.find_by_name("Gender")
    @ages = Condition.where(:category_id => ageId)
    @genders = Condition.where(:category_id => genderID)
    @wins = Condition.where(:category_id => winId)

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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race
      @race = Race.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def race_params
      params.require(:race).permit(:name, :created_at, :updated_at, :race_number, :description, :race_datetime, :winner, :claiming_purse, :status, :send_id, :recv_id, :race_id, :horse_id, :action, :claiming_level, :age_id, :condition_ids => [])
    end
end
