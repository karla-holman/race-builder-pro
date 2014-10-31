class HorsesController < ApplicationController
  before_action :set_horse, only: [:show, :edit, :update, :destroy, :profile, :raceList]

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


  def ownerTransfer
    horse = Horse.find(horse_params[:horse_id])
    horse.owner_id = horse_params[:owner_id]

    if horse.save
      respond_to do |format|
        format.html { redirect_to :back }
      end
    end
  end

  def trainerTransfer
    horse = Horse.find(horse_params[:horse_id])
    horse.trainer_id = horse_params[:trainer_id]

    if horse.save
      respond_to do |format|
        format.html { redirect_to :back }
      end
    end
  end

  # GET /horses/1
  # GET /horses/1.json
  def show
    @categories = Category.where(:datatype => "Bool")
    @statuses = Status.all
    @category_ids = @categories.pluck(:id)
    @conditions = Condition.where("category_id IN (?)", @category_ids)
    @current_status = HorseStatus.where(:horse => @horse).first
    @horse_conditions = @horse.conditions.pluck(:condition_id)
    @race_ids = Array.new()
    @horse.races.all.each do |race|
      @horserace = Horserace.find_or_create_by!(:race_id => race.id, :horse_id => @horse.id)
      if @horserace.status == "Confirmed"
        @comfirmed = true
      end
      if @horserace.status == "Interested" || @horserace.status == "Confirmed"
        @race_ids.push (race.id)
      end
    end

    meet = Meet.all.order('start_date DESC').first
    horsemeet = @horse.horse_meets.where(:meet_id => meet.id)
    weeks = (meet.end_date.to_date - meet.start_date.to_date).to_i / 7

    if horsemeet.empty?
      puts @horse.week_running
      @startsLeft = (weeks/@horse.week_running).floor   
    else
      @startsLeft = (weeks/@horse.week_running).floor - horsemeet.starts
    end

    confirmed_race = Horserace.where(:horse_id => @horse.id, :status => "Confirmed")
    if confirmed_race.any?
      @confirmed = true
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
          if Condition.find(condition).name == "Blinkers On"
            notification = Notification.find_or_create_by!(send_id: @horse.id, recv_id: condition, action: "Add")
            @horse.create_activity :add_blinkers, owner: current_user
          else
            HorseCondition.find_or_create_by!(:horse_id => @horse.id, :condition_id => condition)
          end
        end
      end
      current_conditions = current_conditions.pluck(:condition_id) - horse_params[:condition_ids]
      current_conditions.each do |condition|
        if Condition.find(condition).name == "Blinkers On"
          notification = Notification.find_or_create_by!(send_id: @horse.id, recv_id: condition, action: "Remove")
          @horse.create_activity :remove_blinkers, owner: current_user
        else
          HorseCondition.where(:horse_id => @horse.id, :condition_id => condition).delete_all
        end
      end
    end
    
    respond_to do |format|
      if @horse.update(horse_params)
        if !horse_params[:condition_ids]
          @horse.create_activity :update, owner: current_user
          format.html { redirect_to horses_url, notice: 'Horse was successfully updated.' }
          format.json { render action: 'index', status: :ok, location: @horse }
        else
          @categories = Category.where(:datatype => "Bool")
          format.js
        end

      else
        format.html { render action: 'edit' }
        format.json { render json: @horse.errors, status: :unprocessable_entity }
      end
    end
  end

  def raceList
    @race_ids = Array.new()
    @horse.races.all.each do |race|
      @horserace = Horserace.find_or_create_by!(:race_id => race.id, :horse_id => @horse.id)
      if @horserace.status == "Confirmed"
        @comfirmed = true
      end
      if @horserace.status == "Interested" || @horserace.status == "Confirmed"
        @race_ids.push (race.id)
      end
    end
    if @race_ids.any?
      @races = Race.where("id IN (?)", @race_ids)
    end

    respond_to do |format|
      format.js
    end

  end

  # DELETE /horses/1
  # DELETE /horses/1.json
  def destroy
    @horse.create_activity :destroy, parameters: {name: @horse.name}, owner: current_user
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
      params.require(:horse).permit(:name, :POB, :gender, :birth_year, :starts, :wins, :seconds, :owner_id, :horse_id, :last_win, :last_claiming_level, :trainer_id, :condition_ids => [])
    end
end
