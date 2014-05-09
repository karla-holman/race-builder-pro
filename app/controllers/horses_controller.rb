class HorsesController < ApplicationController
  before_action :set_horse, only: [:show, :edit, :update, :destroy]

  # GET /horses
  # GET /horses.json
  def index
    if params[:search]
      @horses = Horse.search(params[:search]).order("name ASC")   
    elsif current_user.admin?
      @horses = Horse.all
    elsif current_user.trainer?
      @horses = Horse.where(:trainer_id => current_user.id)
    else
      @horses = Horse.where(:owner_id => current_user.id)
    end
  end

  # GET /horses/1
  # GET /horses/1.json
  def show
    @categories = Category.where(:datatype => "Bool")
    @statuses = Status.all
    @category = @categories.pluck(:id)
    @conditions = Condition.where("category_id IN (?)", @category)
    @current_status = HorseStatus.where(:horse => @horse).first
    @horse_conditions = @horse.conditions.pluck(:condition_id)
    @race_ids = Array.new()
    
    Race.all.each do |race|
      bool_conditions = race.conditions.where("category_id IN (?)", @category).pluck(:condition_id)
      specific_conditions = race.conditions.pluck(:condition_id) - bool_conditions
      if (@horse_conditions - bool_conditions).empty?
        @race_ids.push(race.id)
        if (specific_conditions.any?)
          specific_conditions.each do |specific_condition|
            condition = Condition.find(specific_condition)
            category = condition.category           
            case category.name
            when 'Age'
              specific_value  = age(@horse.DOB.to_date)
              success = filter_range(condition, specific_value)
            when 'Wins'
              specific_value = @horse.firsts
              success = filter_range(condition, specific_value)
            when 'Gender'
              if condition.value == @horse.gender
                success = "yes"
              end 
            end
            if success != "yes"
              @race_ids.pop
              break
            end        
          end
        end
      end
    end
    if @race_ids.any?
      @races = Race.where("id IN (?)", @race_ids)
      @races.each do |race|
        Horserace.find_or_create_by!(:race_id => race.id, :horse_id => @horse.id)
      end
    end
  end

  # GET /horses/new
  def new
    @horse = Horse.new
    @owners = User.where(:role => '0')
    @trainers = User.where(:role => '1')
    @statuses = HorseStatus.all
    @sexes = { "Mare" => "M", "Filly" => "F", "Colt" => "C", "Gelding" => "G", "Horse" => "H", "Ridgling" => "R" }
  end

  # GET /horses/1/edit
  def edit
    @owners = User.where(:role => '0')
    @trainers = User.where(:role => '1')
    @sexes = { "Mare" => "M", "Filly" => "F", "Colt" => "C", "Gelding" => "G", "Horse" => "H", "Ridgling" => "R" }
  end

  # POST /horses
  # POST /horses.json
  def create
    @horse = Horse.new(horse_params)
    respond_to do |format|
      if @horse.save
        horse_status = HorseStatus.new(:horse_id => @horse.id, :status_id => 2)
        horse_status.save
        format.html { redirect_to horses_url, notice: 'Horse was successfully created.' }
        format.json { render action: 'index', status: :created, location: @horse }
      else
        format.html { render action: 'new' }
        format.json { render json: @horse.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /horses/1
  # PATCH/PUT /horses/1.json
  def update
    if params[:condition_ids]
      current_conditions = HorseCondition.where(:horse => @horse)
      params[:condition_ids].each do |condition|
        HorseCondition.find_or_create_by!(condition_id: condition, horse_id: @horse.id)
      end
      current_conditions.each do |condition|
        found = params[:condition_ids].find(condition.id)
        if found
        else
          condition.destroy
        end
      end
      format.html { redirect_to @horse, notice: 'Horse was successfully updated.' }
      format.json { render action: 'show', status: :ok, location: @horse }
    else
      respond_to do |format|
        if @horse.update(horse_params)
          format.html { redirect_to horses_url, notice: 'Horse was successfully updated.' }
          format.json { render action: 'index', status: :ok, location: @horse }
        else
          format.html { render action: 'edit' }
          format.json { render json: @horse.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /horses/1
  # DELETE /horses/1.json
  def destroy
    @horse.destroy
    respond_to do |format|
      format.html { redirect_to horses_url }
      format.json { head :no_content }
    end
  end

  def age(dob)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
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
    def set_horse
      @horse = Horse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def horse_params
      params.require(:horse).permit(:name, :POB, :gender, :DOB, :starts, :firsts, :seconds, :thirds, :earnings, :owner_id, :trainer_id, :condition_ids => [])
    end
end
