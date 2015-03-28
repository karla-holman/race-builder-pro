class HorsesController < ApplicationController
  before_action :set_horse, only: [:show, :edit, :update, :destroy, :profile, :raceList]
  skip_before_filter  :verify_authenticity_token

  # GET /horses
  # GET /horses.json
  def index
    @inactive = Status.find_by_name('Inactive')
    if current_user.admin?
      @horses = Horse.all
    elsif current_user.trainer?
      @horses = Horse.where(:trainer_id => current_user.id).where.not(:status => @inactive)
    else
      @horses = Horse.where(:owner_id => current_user.id).where.not(:status => @inactive)
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
    @last_win = @horse.last_win
    
    @lasix_medication = Equipment.where("name = (?) OR name = (?) OR name = (?)", "Lasix Off", "Lasix On", 'First Time Lasix')
    @equipment_medication = Equipment.where("name != (?) AND name != (?) AND name != (?)", "Lasix Off", "Lasix On", 'First Time Lasix')

    @lasix_medication.each do |equipment|
      if Notification.where(:send_id => @horse.id, :recv_id => equipment.id, :action => "Add").any? || Notification.where(:send_id => @horse.id, :recv_id => equipment.id, :action => "Remove").any?
        @lasix_pending = true
      end
    end
    if current_user.admin?
      @statuses = Status.all
    else
      @statuses = Status.where.not(:name => 'Inactive')
    end
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

    confirmed_race = Horserace.where(:horse_id => @horse.id, :status => "Confirmed")

     if confirmed_race.any?
      confirmed_race.each do |horserace|
        if horserace.race
          @confirmed = true
          @confirmed_race = horserace.race.name
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
    @last_win = LastWin.new
    @owners = User.where(:role => '0')
    @trainers = User.where(:role => '1')
    @statuses = Status.all
    @sexes = { "Mare" => "M", "Filly" => "F", "Colt" => "C", "Gelding" => "G", "Horse" => "H", "Ridgling" => "R" }
  end

  # GET /horses/1/edit
  def edit
    @last_win = @horse.last_win
    @owners = User.where(:role => '0')
    @trainers = User.where(:role => '1')

    if (@horse.owner == @horse.trainer)
      @ownerIsTrainer = true
    end

    @sexes = { "Mare" => "M", "Filly" => "F", "Colt" => "C", "Gelding" => "G", "Horse" => "H", "Ridgling" => "R" }
  end

  # POST /horses
  # POST /horses.json
  def create
    @horse = Horse.find_by_name(horse_params[:name])
    if @horse
      respond_to do |format|
        @horse = Horse.new(horse_params)
        @horse.errors.add(:name, "Already in use.")
        @last_win = LastWin.new
        @owners = User.where(:role => '0')
        @trainers = User.where(:role => '1')
        @statuses = Status.all
        @sexes = { "Mare" => "M", "Filly" => "F", "Colt" => "C", "Gelding" => "G", "Horse" => "H", "Ridgling" => "R" }
        format.html { render action: 'new', notice: 'Horse name already taken.'}
      end
    else
      @horse = Horse.new(horse_params)

      if params[:trainer_owner]
        @horse.owner = @horse.trainer
      end

      if !horse_params[:subregion_code]
        @horse.subregion_code = Carmen::Country.coded(horse_params[:country_code]).subregions.sort_by!{ |s| s.name.downcase }.first.code
      end
      @last_win = LastWin.new
      @last_win.date = params[:last_win][:date]
      @last_win.distance_type = params[:last_win][:distance_type]
      @last_win.distance = params[:last_win][:distance]
      @last_win.money_earned = params[:last_win][:money_earned]
      @last_win.horse_id = @horse.id
      @last_win.save
      @horse.last_win = @last_win
      @race_ready = Status.find_by_name("Race Ready")
      @horse.status= @race_ready
      respond_to do |format|
        if @horse.save
          @horse.create_activity :create, owner: current_user
          format.html { redirect_to horses_url, notice: 'Horse was successfully created.' }
          format.json { render action: 'index', status: :created, location: @horse }
        else
          format.html { render action: 'new' }
          format.json { render json: @horse.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /horses/1
  # PATCH/PUT /horses/1.json
  def update
    @compare_horse = Horse.find_by_name(horse_params[:name])
    if @compare_horse && @compare_horse != @horse
      respond_to do |format|
        @last_win = @horse.last_win
        @owners = User.where(:role => '0')
        @trainers = User.where(:role => '1')

        if (@horse.owner == @horse.trainer)
          @ownerIsTrainer = true
        end

        @horse.errors.add(:name, "Already in use.")
        @statuses = Status.all
        @sexes = { "Mare" => "M", "Filly" => "F", "Colt" => "C", "Gelding" => "G", "Horse" => "H", "Ridgling" => "R" }
        format.html { render action: 'edit', notice: 'Horse name already taken.'}
      end
    else
      if horse_params[:equipment_ids]
        horse_params[:equipment_ids].each do |equipment|
          if HorseEquipment.where(equipment_id: equipment, horse_id: @horse.id).empty? && !equipment.empty?
            if Equipment.find(equipment).required && !current_user.admin?
              notification = Notification.find_or_create_by!(send_id: @horse.id, recv_id: equipment, action: "Add")
              @horse.create_activity :add_equipment_request, parameters: {name: Equipment.find(equipment).name}, owner: current_user
            else
              HorseEquipment.find_or_create_by!(:horse_id => @horse.id, :equipment_id => equipment)
              @horse.create_activity :add_equipment, parameters: {name: Equipment.find(equipment).name}, owner: current_user
            end
          end
        end
        
        current_equipment = @horse.equipment.pluck(:id) - horse_params[:equipment_ids].map(&:to_i)

        current_equipment.each do |equipment|
          if Equipment.find(equipment).required && !current_user.admin?
            notification = Notification.find_or_create_by!(send_id: @horse.id, recv_id: equipment, action: "Remove")
            @horse.create_activity :remove_equipment_request, parameters: {name: Equipment.find(equipment).name}, owner: current_user
          else
            HorseEquipment.where(:horse_id => @horse.id, :equipment_id => equipment).first.destroy
            @horse.create_activity :remove_equipment, parameters: {name: Equipment.find(equipment).name}, owner: current_user
          end
        end
      end
      if params[:last_win]
        @last_win = @horse.last_win
        if params[:last_win][:date]
          @last_win.date = params[:last_win][:date]
        end
        if params[:last_win][:distance_type]
          @last_win.distance_type = params[:last_win][:distance_type]
        end
        if params[:last_win][:distance]
          @last_win.distance = params[:last_win][:distance]
        end
        if params[:last_win][:money_earned]
          @last_win.money_earned = params[:last_win][:money_earned]
        end

        @last_win.horse_id = @horse.id
        @last_win.save
        @horse.last_win = @last_win
      end
      if horse_params[:status_id]
        status = Status.find(horse_params[:status_id])
        vets = Status.find_by_name('Vet\'s List')
        steward = Status.find_by_name('Steward\'s List')

        if status == vets || status == steward
          notification = Notification.find_or_create_by!(send_id: horse_params[:status_id], recv_id: @horse.id, action: "Status Changed")
          notification.save
        end
      end
      if horse_params[:country_code] && !horse_params[:subregion_code]
        @horse.subregion_code = Carmen::Country.coded(horse_params[:country_code]).subregions.sort_by!{ |s| s.name.downcase }.first.code
      end
      respond_to do |format|
        if !horse_params[:equipment_ids]
          if @horse.update(horse_params)
            if params[:trainer_owner]
              @horse.owner = @horse.trainer
            end
            if @horse.horse_filter_setting
              @horse.horse_filter_setting.delete
            end
            @horse.save
            @horse.create_activity :update, owner: current_user
            format.html { redirect_to horses_url, notice: 'Horse was successfully updated.' }
            format.json { render action: 'index', status: :ok, location: @horse }
          else
            format.html { render action: 'edit' }
            format.json { render json: @horse.errors, status: :unprocessable_entity }
          end
        else
          @lasix_medication = Equipment.where("name = (?) OR name = (?) OR name = (?)", "Lasix Off", "Lasix On", 'First Time Lasix')
          @equipment_medication = Equipment.where("name != (?) AND name != (?) AND name != (?)", "Lasix Off", "Lasix On", 'First Time Lasix')
          @lasix_medication.each do |equipment|
            if Notification.where(:send_id => @horse.id, :recv_id => equipment.id, :action => "Add").any? || Notification.where(:send_id => @horse.id, :recv_id => equipment.id, :action => "Remove").any?
              @lasix_pending = true
            end
          end
          format.js
        end
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

  def subregion_options
    render partial: 'subregion_select'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_horse
      @horse = Horse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def horse_params
      params.require(:horse).permit(:name, :breed, :URL, :country_code, :subregion_code, :sex, :birth_year, :starts, :wins, :seconds, :owner_id, :horse_id, :status_id, :last_win, :last_claiming_price, :trainer_id, :equipment_ids => [])
    end
end
