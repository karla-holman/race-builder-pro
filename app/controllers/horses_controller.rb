class HorsesController < ApplicationController
  before_action :set_horse, only: [:show, :edit, :update, :destroy, :profile]

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

  # get /HORSES/1/profile
  def profile
    @categories = Category.where(:datatype => "Bool")
    @statuses = Status.all
    @category = @categories.pluck(:id)
    @conditions = Condition.where("category_id IN (?)", @category)
    @current_status = HorseStatus.where(:horse => @horse).first
    @horse_conditions = @horse.conditions.pluck(:condition_id)
    @race_ids = Array.new()

    @horse.races.all.each do |race|
      @horserace = Horserace.find_or_create_by!(:race_id => race.id, :horse_id => @horse.id)
      if @horserace.status == "interested" || @horserace.status == "confirmed"
        @race_ids.push (race.id)
      end
    end

    if @race_ids.any?
      @races = Race.where("id IN (?)", @race_ids)
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
      end
    end
    if @race_ids.any?
      @races = Race.where("id IN (?)", @race_ids)
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
        @horse.create_activity :create, owner: current_user
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
    current_conditions = HorseCondition.where(:horse => @horse)
    if horse_params[:condition_ids]
      horse_params[:condition_ids].each do |condition|
        if HorseCondition.where(condition_id: condition, horse_id: @horse.id).empty? && !condition.empty?   
          pending_condition = PendingCondition.find_or_create_by!(condition_id: condition, horse_id: @horse.id, action: "add") 
        end
      end
      current_conditions = current_conditions.pluck(:condition_id) - horse_params[:condition_ids]
      current_conditions.each do |condition|
        puts "pending remove condition"
        PendingCondition.find_or_create_by!(condition_id: condition, horse_id: @horse.id, action: "remove")
      end
    end
    respond_to do |format|
      if @horse.update(horse_params)
        if !horse_params[:condition_ids]
          @horse.create_activity :update, owner: current_user
        end
        format.html { redirect_to horses_url, notice: 'Horse was successfully updated.' }
        format.json { render action: 'index', status: :ok, location: @horse }
      else
        format.html { render action: 'edit' }
        format.json { render json: @horse.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /horses/1
  # DELETE /horses/1.json
  def destroy
    @horse.destroy
    respond_to do |format|
      @horse.create_activity :destroy, owner: current_user
      format.html { redirect_to horses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_horse
      @horse = Horse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def horse_params
      params.require(:horse).permit(:name, :POB, :gender, :DOB, :starts, :firsts, :seconds, :thirds, :earnings, :owner_id, :last_win, :last_claiming_level, :trainer_id, :condition_ids => [])
    end
end
