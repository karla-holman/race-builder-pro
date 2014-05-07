class HorsesController < ApplicationController
  before_action :set_horse, only: [:show, :edit, :update, :destroy]

  # GET /horses
  # GET /horses.json
  def index
    if current_user.admin?
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
    @categories = Category.all
    @conditions = Condition.all
    @statuses = Status.all
    @current_status = HorseStatus.where(:horse => @horse).first
    
    horse_conditions = @horse.conditions.pluck(:condition_id)
    race_ids = Array.new()
    Race.all.each do |race|
      if (race.conditions.pluck(:condition_id) - horse_conditions).empty?
        race_ids.push(race.id)
      end
    end
    if race_ids.any?
      @races = Race.where("id IN (?)", race_ids)
    else
      @races = Race.all   
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
