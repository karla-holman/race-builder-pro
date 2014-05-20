class RacesController < ApplicationController
  before_action :set_race, only: [:show, :edit, :update, :destroy]

  # GET /races
  # GET /races.json
  def index
    if params[:search]
      @races = Race.search(params[:search]).order("name ASC")   
    else current_user.admin?
      @races = Race.all
    end
  end

  # GET /races/1
  # GET /races/1.json
  def show
    @categories = Category.all - Category.where(:datatype => "Bool")
    @race_conditions = RaceCondition.where(:race => @race)
    confirmed_ids = Horserace.where(:race_id => @race.id, :status => "confirmed").pluck(:horse_id)
    interested_ids = Horserace.where(:race_id => @race.id, :status => "interested").pluck(:horse_id)
    @confirmed = Horse.where("id IN (?)", confirmed_ids)
    @interested = Horse.where("id IN (?)", interested_ids)
    
    if @confirmed.empty? && @interested.empty?
      "BOTH EMPTY"
      possible_horses = Horse.all
    elsif @confirmed.empty?
      puts "NO CONFIRMED"
      possible_horses = Horse.where("id not IN (?)", interested_ids)
    elsif @interested.empty?
      puts "NO INTERESTED"
      possible_horses = Horse.where("id not IN (?)", confirmed_ids)
    else
      puts "ELSE"
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

  def filter_range(condition, value)
    if condition.lowerbound.nil?
      if value > condition.upperbound
        return "no"
      else
        return "yes"
      end
    elsif condition.upperbound.nil?
      if value < condition.lowerbound
        return "no"
      else
        return "yes"
      end
    else
      if condition.upperbound < value || value < condition.lowerbound
        return "no"
      else
        return "yes"
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race
      @race = Race.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def race_params
      params.require(:race).permit(:name, :created_at, :updated_at, :race_number, :description, :race_datetime, :winner, :claiming_purse, :claiming_level, :condition_ids => [])
    end
end
