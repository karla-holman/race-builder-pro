class RacesController < ApplicationController
  before_action :set_race, only: [:show, :edit, :update, :destroy, :racefinish, :duplicate_race, :resetHorseStatuses, :edit_with_condition_node, :removeConfirmedHorses]
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
    confirmed_ids = Horserace.where("race_id = (?) AND (status = (?) OR status = (?) OR status = (?))", @race.id, "Confirmed", "Scratched", "WON").pluck(:horse_id)
    @confirmed = Horse.where("id IN (?)", confirmed_ids)
    @trainers = User.where(:role => 1)
    @owners = User.where(:role => 0)
    @resetHorses = false

    @race.horses.each do |horse|
      if horse.status.name == 'Running'
        @resetHorses = true
      end
    end
  end

  # GET /races/1
  # GET /races/1.json
  def show
    confirmed_ids = Horserace.where("race_id = (?) AND (status = (?) OR status = (?) OR status = (?))", @race.id, "Confirmed", "Scratched", "WON").pluck(:horse_id)
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
      @race_groups = [["Confirmed", @confirmed], ["Pending", @pending], ["Denied", @denied]]
    else
      @race_groups = [["Confirmed", @confirmed], ["Interested", @interested]]
    end
  end

  def new_with_condition_node
    @race = Race.new
    @claiming_one = ClaimingPrice.new
    @claiming_two = ClaimingPrice.new

    if race_params && race_params[:condition_node_id]
      condition_node = ConditionNode.find_by_id(race_params[:condition_node_id])
      saved_race = Rails.cache.read('New_Race_'+current_user.id.to_s)
      if saved_race
        @race.name = saved_race[:race][:name]
        @race.description = saved_race[:race][:description]
        @race.weights = saved_race[:race][:weights]
        @race.stakes = saved_race[:race][:stakes]
        @race.hasOtherConditions = saved_race[:race][:hasOtherConditions]
        @race.needs_nomination = saved_race[:race][:needs_nomination]
        @race.status = saved_race[:race][:status]
        @race.purse = saved_race[:race][:purse].gsub(/[^\d\.]/, '')
        @race.max_field_size = saved_race[:race][:max_field_size]
        @race.race_type = saved_race[:race][:race_type]
        @race.condition_node = condition_node

        if saved_race[:claiming_one]
          @claiming_one = ClaimingPrice.new(:price => saved_race[:claiming_one].gsub(/[^\d\.]/, ''))
        else
          @claiming_one = ClaimingPrice.new
        end
        if saved_race[:claiming_two]
          @claiming_two = ClaimingPrice.new(:price => saved_race[:claiming_two].gsub(/[^\d\.]/, ''))
        else
          @claiming_two = ClaimingPrice.new
        end

        if saved_race[:distance]
          @race_distance = RaceDistance.new(:distance => saved_race[:distance])
          @race_distance.distance_type = saved_race[:distance_type]
          @race_distance.fraction_string = saved_race[:fraction_string]
          @race_distance.yards = saved_race[:yards]
        else
          @race_distance = RaceDistance.new
        end
        
        if(saved_race[:category])
          @race.category = 'Priority'
          if(saved_race[:race_date] && !saved_race[:race_date][:date].empty?)
            race_date = RaceDate.new       
            race_date.date = saved_race[:race_date][:date]
            @race.race_date = race_date
          end
          if(saved_race[:race][:stakes] && saved_race[:race][:needs_nomination] && !saved_race[:nomination_close_date][:date].empty?)
              nom_close_date = NominationCloseDate.new
              nom_close_date.date = saved_race[:nomination_close_date][:date]
              @race.nomination_close_date = nom_close_date
          end
        else
          @race.category = 'Alternate'
        end
      end
    end

    respond_to do |format|
      format.html { render 'new' }
    end
  end

  def edit_with_condition_node
    @claiming_one = ClaimingPrice.new
    @claiming_two = ClaimingPrice.new

    saved_race = Rails.cache.read('Edit_Race_'+current_user.id.to_s)
    if saved_race
      @race.name = saved_race[:race][:name]
      @race.description = saved_race[:race][:description]
      @race.weights = saved_race[:race][:weights]
      @race.stakes = saved_race[:race][:stakes]
      @race.hasOtherConditions = saved_race[:race][:hasOtherConditions]
      @race.needs_nomination = saved_race[:race][:needs_nomination]
      @race.status = saved_race[:race][:status]
      @race.purse = saved_race[:race][:purse].gsub(/[^\d\.]/, '')
      @race.max_field_size = saved_race[:race][:max_field_size]
      @race.race_type = saved_race[:race][:race_type]

      if saved_race[:claiming_one]
        @claiming_one = ClaimingPrice.new(:price => saved_race[:claiming_one].gsub(/[^\d\.]/, ''))
      else
        @claiming_one = ClaimingPrice.new
      end
      if saved_race[:claiming_two]
        @claiming_two = ClaimingPrice.new(:price => saved_race[:claiming_two].gsub(/[^\d\.]/, ''))
      else
        @claiming_two = ClaimingPrice.new
      end

      if saved_race[:distance]
        @race_distance = RaceDistance.new(:distance => saved_race[:distance])
        @race_distance.distance_type = saved_race[:distance_type]
        @race_distance.fraction_string = saved_race[:fraction_string]
        @race_distance.yards = saved_race[:yards]
      else
        @race_distance = RaceDistance.new
      end
      
      if(saved_race[:category])
        @race.category = 'Priority'
        if(saved_race[:race_date] && !saved_race[:race_date][:date].empty?)
          race_date = RaceDate.new       
          race_date.date = saved_race[:race_date][:date]
          @race.race_date = race_date
        end
        if(saved_race[:race][:stakes] && saved_race[:race][:needs_nomination] && !saved_race[:nomination_close_date][:date].empty?)
          nom_close_date = NominationCloseDate.new
          nom_close_date.date = saved_race[:nomination_close_date][:date]
          @race.nomination_close_date = nom_close_date
        end
      else
        @race.category = 'Alternate'
      end
    end

    respond_to do |format|
      format.html { render 'edit' }
    end
  end

  # GET /races/new
  def new
    @race = Race.new
    @claiming_one = ClaimingPrice.new
    @claiming_two = ClaimingPrice.new
    @race_distance = RaceDistance.new
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
      @horses = Horse.where(:trainer_id => current_user.id).where.not(:status => @inactive).order('name ASC')
    else
      @horses = Horse.where(:owner_id => current_user.id).where.not(:status => @inactive).order('name ASC')
    end
  end

  def raceList
    @horse = Horse.find(params[:horse_id])
    @races = FilterRacesService.new.horseFilter(@horse)
    
    if(params[:loadSettings])
      if @horse.horse_filter_setting
        if @horse.horse_filter_setting.age_id
          @age = Condition.find_by_id(@horse.horse_filter_setting.age_id)
          @races = FilterRacesService.new.conditionFilter(@races, @age)
        end
        if @horse.horse_filter_setting.wins_id
          if @horse.horse_filter_setting.wins_id == -1
            @wins = Condition.new(:name => 'Open', :id => -1)
            @races = FilterRacesService.new.noWinsFilter(@races)
          else
            @wins = Condition.find_by_id(@horse.horse_filter_setting.wins_id)
            @races = FilterRacesService.new.conditionFilter(@races, @wins)
          end
        end
        if @horse.horse_filter_setting.bred_id
          @bred = Condition.find_by_id(@horse.horse_filter_setting.bred_id)
          @races = FilterRacesService.new.conditionFilter(@races, @bred)
        end
        if @horse.horse_filter_setting.sex
          @sex = @horse.horse_filter_setting.sex
          @races = FilterRacesService.new.sexFilter(@races, @sex)
        end
        if @horse.horse_filter_setting.distance
          @distance = @horse.horse_filter_setting.distance
          @races = FilterRacesService.new.distanceFilter(@races, @distance)
        end
        if @horse.horse_filter_setting.lower_claiming
          claimingprices = ClaimingPrice.all.pluck(:price).reject(&:blank?).uniq.sort
          if(claimingprices.include? @horse.horse_filter_setting.lower_claiming)
            @lower_claiming = @horse.horse_filter_setting.lower_claiming
            @races = FilterRacesService.new.lowerClaimingFilter(@races, @lower_claiming)
          else
            @horse.horse_filter_setting.lower_claiming = nil
          end
        end
        if @horse.horse_filter_setting.upper_claiming
          claimingprices = ClaimingPrice.all.pluck(:price).reject(&:blank?).uniq.sort
          if(claimingprices.include? @horse.horse_filter_setting.upper_claiming)
            @upper_claiming = @horse.horse_filter_setting.upper_claiming
            @races = FilterRacesService.new.upperClaimingFilter(@races, @upper_claiming)
          else
            @horse.horse_filter_setting.lower_claiming = nil
          end
        end
      else
        horse_filter = HorseFilterSetting.new(horse_id: @horse.id)

        if @horse.age == 2 && @horse.sex == 'F'
          horse_filter.sex = 'F'
          @sex = horse_filter.sex
          @races = FilterRacesService.new.sexFilter(@races, @sex)
        elsif @horse.sex == 'F' || @horse.sex == 'M'
          horse_filter.sex = 'F/M'
          @sex = horse_filter.sex
          @races = FilterRacesService.new.sexFilter(@races, @sex)
        end

        if(@horse.wins == 0)
          @wins = Condition.find_by_name("Maiden")
          if @wins
            horse_filter.wins_id = @wins.id
            @races = FilterRacesService.new.conditionFilter(@races, @wins)
          end
        end
        horse_filter.save
        @horse.horse_filter_setting = horse_filter
        @horse.save
      end
    else
      if !params[:age_id].blank?
        @age = Condition.find_by_id(params[:age_id])

        if @horse.sex == 'F' 
          if @age.name == '3YO' || @age.name == '3YO'
            if @horse.horse_filter_setting
              @horse.horse_filter_setting.sex == 'F'
              params[:sex] = 'F'
            end
          end

          if @age.name == '3+' || @age.name == '4+'
            if @horse.horse_filter_setting
              @horse.horse_filter_setting.sex == 'F/M'
              params[:sex] = 'F/M'
            end
          end
        end
        @races = FilterRacesService.new.conditionFilter(@races, @age)
        @horse.horse_filter_setting.age_id = params[:age_id]
      else
        @horse.horse_filter_setting.age_id = nil
      end
      if !params[:wins_id].blank?
        if params[:wins_id].to_i == -1
            @wins = Condition.new(:name => 'Open', :id => -1)
            @races = FilterRacesService.new.noWinsFilter(@races)
        else
          @wins = Condition.find_by_id(params[:wins_id])
          @races = FilterRacesService.new.conditionFilter(@races, @wins)
        end
        @horse.horse_filter_setting.wins_id = @wins.id
      else
        @horse.horse_filter_setting.wins_id = nil
      end
      if !params[:bred_id].blank?
        @bred = Condition.find_by_id(params[:bred_id])
        @races = FilterRacesService.new.conditionFilter(@races, @bred)
        @horse.horse_filter_setting.bred_id = params[:bred_id]
      else
        @horse.horse_filter_setting.bred_id = nil
      end
      if !params[:sex].blank?
        @sex = params[:sex]
        @races = FilterRacesService.new.sexFilter(@races, @sex)
        @horse.horse_filter_setting.sex = params[:sex]
      else
        @horse.horse_filter_setting.sex = nil
      end
      if !params[:distance].blank?
        @distance = params[:distance]
        @races = FilterRacesService.new.distanceFilter(@races, @distance)
        @horse.horse_filter_setting.distance = params[:distance]
      else
        @horse.horse_filter_setting.distance = nil
      end
      if !params[:lower_claiming].blank?
        @lower_claiming = params[:lower_claiming]
        @races = FilterRacesService.new.lowerClaimingFilter(@races, @lower_claiming)
        @horse.horse_filter_setting.lower_claiming = params[:lower_claiming]
      else
        @horse.horse_filter_setting.lower_claiming = nil
      end
      if !params[:upper_claiming].blank?
        @upper_claiming =  params[:upper_claiming]
        @races = FilterRacesService.new.upperClaimingFilter(@races, @upper_claiming)
        @horse.horse_filter_setting.upper_claiming = params[:upper_claiming]
      else
        @horse.horse_filter_setting.upper_claiming = nil
      end
    end

     @horse.horse_filter_setting.save

     @ageList = FilterRacesService.new.ageCategories(@horse)
     @winList = FilterRacesService.new.winCategories(@horse)
     @bredList = FilterRacesService.new.bredCategories(@horse)
     @claiming_prices = ClaimingPrice.all.pluck(:price).reject(&:blank?).uniq.sort

     confirmed_race = Horserace.where(:horse_id => @horse.id, :status => "Confirmed")

     if confirmed_race.any?
      confirmed_race.each do |horserace|
        if horserace.race
          @confirmed = true
          @confirmed_race = horserace.race.name
        end
      end
     end

    respond_to do |format|
      format.js
    end
  end

  # GET /races/1/edit
  def edit
    @race_date = @race.race_date
    if(@race.claiming_prices[0])
      if @race.claiming_prices[0].lower
        @claiming_one = @race.claiming_prices[0]
      else
        @claiming_two = @race.claiming_prices[0]
      end
    end

    if(@race.claiming_prices[1])
      if @race.claiming_prices[1].lower
        @claiming_one = @race.claiming_prices[1]
      else
        @claiming_two = @race.claiming_prices[1]
      end
    end

    if @claiming_one.nil?
      @claiming_one = ClaimingPrice.new
    end

    if @claiming_two.nil?
      @claiming_two = ClaimingPrice.new
    end

    if @race.race_distance
      @race_distance = @race.race_distance
    else
      @race_distance = RaceDistance.new
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
    if(race_params[:purse])
      @race.purse = race_params[:purse].gsub(/[^\d\.]/, '')
    end
    if(params[:commit] == 'Add Conditions')
      @root = ConditionNode.new
      @root.setAsRoot
      @root.save
      Rails.cache.write('New_Race_'+current_user.id.to_s, params)
    elsif(params[:commit] == 'Edit Conditions')
      @root = ConditionNode.find_by_id(params[:condition_node_id])
      Rails.cache.write('New_Race_'+current_user.id.to_s, params) 
    else
      if(params[:claiming_one])
        @claiming_one = ClaimingPrice.new(:price => params[:claiming_one].gsub(/[^\d\.]/, ''))
      else
        @claiming_one = ClaimingPrice.new
      end
      if(params[:claiming_two])
        @claiming_two = ClaimingPrice.new(:price => params[:claiming_two].gsub(/[^\d\.]/, ''))
      else
        @claiming_two = ClaimingPrice.new
      end
      if params[:distance]
        @race_distance = RaceDistance.new(:distance => params[:distance])
        @race_distance.distance_type = params[:distance_type]
        @race_distance.fraction_string = params[:fraction_string]
        @race_distance.yards = params[:yards]
      end
      if(!race_params[:name] || race_params[:name].empty?)
          @race.errors.add('Race name', "is missing")
      end
      if(!race_params[:purse] || race_params[:purse].empty?)
          @race.errors.add('Race purse', "is missing")
      end
      if(!params[:distance] || params[:distance].empty?)
          @race.errors.add('Race distance', "is missing")
      end
      if(params[:category])
        @race.category = 'Priority'
        if(params[:race_date] && !params[:race_date][:date].empty?)
          @race_date = RaceDate.new
          @race_date.race_id = @race.id         
          @race_date.date = params[:race_date][:date]
          @race_date.save
          @race.race_date = @race_date
        else
          @race.errors.add('Priority', "Race must have a date.")
        end
        if race_params[:stakes] == '1' && race_params[:needs_nomination] == '1'
          if !params[:nomination_close_date][:date].empty?
            nom_close_date = NominationCloseDate.new
            nom_close_date.date = params[:nomination_close_date][:date]
            nom_close_date.save
            @race.nomination_close_date = nom_close_date
          else
            @race.errors.add('Stakes', "Race that needs nominations must have a close date.")
          end
        end
      else
        @race.category = 'Alternate'
      end
      if(!race_params[:race_type] || race_params[:race_type].empty?)
          @race.errors.add('Race type', "must be selected")
      end
      if params[:condition_node_id]
        condition_node = ConditionNode.find_by_id(params[:condition_node_id])
        @race.condition_node = condition_node
      end
    end
    respond_to do |format|
      if(params[:commit] == 'Add Conditions' || params[:commit] == 'Edit Conditions')
         format.html { redirect_to edit_condition_node_path(@root) }
      elsif !@race.errors.any? && @race.save
        if(params[:claiming_one] && @race.isClaiming)
          if(@race.claiming_prices[0])
            @race.claiming_prices[0].price = params[:claiming_one].gsub(/[^\d\.]/, '')
            @claiming_one.lower = true
            @race.claiming_prices[0].save
          else
            @claiming_one = ClaimingPrice.new
            @claiming_one.race_id = @race.id
            @claiming_one.price = params[:claiming_one].gsub(/[^\d\.]/, '')
            @claiming_one.lower = true
            @claiming_one.save
            @race.claiming_prices[0] = @claiming_one
          end
        end
        if (params[:claiming_two] && @race.isClaiming)
          if(@race.claiming_prices[1])
            @race.claiming_prices[1].price = params[:claiming_two].gsub(/[^\d\.]/, '')
            @claiming_one.lower = false
            @race.claiming_prices[1].save
          else
            @claiming_two = ClaimingPrice.new
            @claiming_two.race_id = @race.id
            @claiming_two.price = params[:claiming_two].gsub(/[^\d\.]/, '')
            @claiming_one.lower = false
            @claiming_two.save
            @race.claiming_prices[1] = @claiming_two
          end
        end
        if params[:distance]
          @distance = RaceDistance.new(:distance => params[:distance])
          @distance.race_id = @race.id
          @distance.distance_type = params[:distance_type]
          @distance.fraction_string = params[:fraction_string]
          @distance.yards = params[:yards]
          @distance.save
          @race.race_distance = @distance
        end
        @race.save
        if params[:condition_node_id]
          condition_node = ConditionNode.find_by_id(params[:condition_node_id])
          condition_node.value = @race.id
          condition_node.save
          @race.condition_node = condition_node
          Rails.cache.clear('New Race') 
          if condition_node.getExpressionString
            @race.description = condition_node.getExpressionString
          end
          @race.save
        end
        if @race.category == 'Priority'
          addRaceToTEL(@race)
        end
        if(params[:commit] == 'Save and Duplicate')
          new_race = @race.dup
          new_race.save
          if @race.race_distance
            new_distance = @race.race_distance.dup
            new_distance.race_id = new_race.id
            new_distance.save
            new_race.race_distance = new_distance
          end
          if(params[:claiming_one] && @race.isClaiming)
            @claiming_one = ClaimingPrice.new
            @claiming_one.race_id = new_race.id
            @claiming_one.price = params[:claiming_one].gsub(/[^\d\.]/, '')
            @claiming_one.lower = true
            @claiming_one.save
            new_race.claiming_prices[0] = @claiming_one
          end
          if (params[:claiming_two] && @race.isClaiming)
            @claiming_two = ClaimingPrice.new
            @claiming_two.race_id = new_race.id
            @claiming_two.price = params[:claiming_two].gsub(/[^\d\.]/, '')
            @claiming_one.lower = false
            @claiming_two.save
            new_race.claiming_prices[1] = @claiming_two
          end
          if @race.race_date && @race.race_date.date
            @race_date = RaceDate.new
            @race_date.race_id = new_race.id        
            @race_date.date = @race.race_date.date
            @race_date.save
            new_race.race_date = @race_date
          end
          if @race.nomination_close_date && @race.nomination_close_date.date
            @race_date = NominationCloseDate.new
            @race_date.race_id = new_race.id        
            @race_date.date = @race.race_date.date
            @race_date.save
            new_race.nomination_close_date = @race_date
          end
          new_race.cloneConditions(@race)
          new_race.save
          if new_race.category == 'Priority'
            addRaceToTEL(new_race)
          end
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
    if(params[:commit] == 'Edit Conditions')
      @root = ConditionNode.find_by_id(params[:condition_node_id])
      Rails.cache.write('Edit_Race_'+current_user.id.to_s, params)
    else
      if(params[:claiming_one])
        @claiming_one = ClaimingPrice.new(:price => params[:claiming_one].gsub(/[^\d\.]/, ''))
      else
        @claiming_one = ClaimingPrice.new
      end
      if(params[:claiming_two])
        @claiming_two = ClaimingPrice.new(:price => params[:claiming_two].gsub(/[^\d\.]/, ''))
      else
        @claiming_two = ClaimingPrice.new
      end
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
        if(!params[:race_date].empty?)
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
          if(params[:race_date] && !params[:race_date][:date].empty?)
            if !@race.race_date
              @race_date = RaceDate.new
              @race_date.race_id = @race.id         
            else
              @race_date = @race.race_date
            end       
            @race_date.date = params[:race_date][:date]
            @race_date.save
            @race.race_date = @race_date
          else
            @race.errors.add('Priority', "Race must have a date.")
          end
          if race_params[:stakes] == '1' && race_params[:needs_nomination] == '1'
            if !params[:nomination_close_date][:date].empty?
              nom_close_date = NominationCloseDate.new
              nom_close_date.date = params[:nomination_close_date][:date]
              nom_close_date.save
              @race.nomination_close_date = nom_close_date
            else
              @race.errors.add('Stakes', "Race that needs nominations must have a close date.")
            end
          elsif @race.nomination_close_date
            @race.nomination_close_date.delete
          end
        else
          if @race.race_date
            @race.race_date.delete
          end
          if @race.nomination_close_date
            @race.nomination_close_date.delete
          end
          @race.category = 'Alternate'
        end
        if params[:distance]
          @race_distance = RaceDistance.new(:distance => params[:distance])
          @race_distance.distance_type = params[:distance_type]
          @race_distance.fraction_string = params[:fraction_string]
          @race_distance.yards = params[:yards]
        end
        if(!race_params[:name] || race_params[:name].empty?)
          @race.errors.add('Race name', "is missing")
        end
        if(!race_params[:race_type] || race_params[:race_type].empty?)
          @race.errors.add('Race type', "must be selected")
        end
      end
    end
    if @race.errors
      @race = addParams(@race, params)
    end
    respond_to do |format|
      if(params[:commit] == 'Edit Conditions')
       format.html { redirect_to edit_condition_node_path(@root) }
      elsif !@race.errors.any? && @race.update(race_params)
        if(race_params[:purse])
          @race.purse = race_params[:purse].gsub(/[^\d\.]/, '')
        end
        @race.claiming_prices.delete_all
        if @race.race_distance
          @race.race_distance.delete
        end
        if(params[:claiming_one] && @race.isClaiming)
          if(@race.claiming_prices[0])
            @race.claiming_prices[0].price = params[:claiming_one].gsub(/[^\d\.]/, '')
            @race.claiming_prices[0].lower = true
            @race.claiming_prices[0].save
          else
            @claiming_one = ClaimingPrice.new
            @claiming_one.race_id = @race.id
            @claiming_one.price = params[:claiming_one].gsub(/[^\d\.]/, '')
            @claiming_one.lower = true
            @claiming_one.save
            @race.claiming_prices[0] = @claiming_one
          end
        end
        if (params[:claiming_two] && @race.isClaiming)
          if(@race.claiming_prices[1])
            @race.claiming_prices[1].price = params[:claiming_two].gsub(/[^\d\.]/, '')
            @race.claiming_prices[1].lower = false
            @race.claiming_prices[1].save
          else
            @claiming_two = ClaimingPrice.new
            @claiming_two.race_id = @race.id
            @claiming_two.price = params[:claiming_two].gsub(/[^\d\.]/, '')
            @claiming_two.lower = false
            @claiming_two.save
            @race.claiming_prices[1] = @claiming_two
          end
        end
        if params[:distance]
          @distance = RaceDistance.new(:distance => params[:distance])
          @distance.race_id = @race.id
          @distance.distance_type = params[:distance_type]
          @distance.fraction_string = params[:fraction_string]
          @distance.yards = params[:yards]
          @distance.save
          @race.race_distance = @distance
        end
        if @race.condition_node && @race.condition_node.getExpressionString
          @race.description = @race.condition_node.getExpressionString
        end
        @race.save
        if @race.category == 'Priority'
          addRaceToTEL(@race)
        end
        if(params[:commit] == 'Save and Duplicate')
          new_race = @race.dup
          new_race.save
          if @race.race_distance
            new_distance = @race.race_distance.dup
            new_distance.race_id = new_race.id
            new_distance.save
            new_race.race_distance = new_distance
          end
          if(params[:claiming_one] && @race.isClaiming)
            @claiming_one = ClaimingPrice.new
            @claiming_one.race_id = new_race.id
            @claiming_one.price = params[:claiming_one].gsub(/[^\d\.]/, '')
            @claiming_one.lower = true
            @claiming_one.save
            new_race.claiming_prices[0] = @claiming_one
          end
          if (params[:claiming_two] && @race.isClaiming)
            @claiming_two = ClaimingPrice.new
            @claiming_two.race_id = new_race.id
            @claiming_two.price = params[:claiming_two].gsub(/[^\d\.]/, '')
            @claiming_two.lower = false
            @claiming_two.save
            new_race.claiming_prices[1] = @claiming_two
          end
          if @race.race_date && @race.race_date.date
            @race_date = RaceDate.new
            @race_date.race_id = new_race.id        
            @race_date.date = @race.race_date.date
            @race_date.save
            new_race.race_date = @race_date
          end
          if @race.nomination_close_date && @race.nomination_close_date.date
            @race_date = NominationCloseDate.new
            @race_date.race_id = new_race.id        
            @race_date.date = @race.race_date.date
            @race_date.save
            new_race.nomination_close_date = @race_date
          end
          new_race.cloneConditions(@race)
          new_race.save
          if new_race.category == 'Priority'
            addRaceToTEL(new_race)
          end
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

  def addParams(race, params)
    race.name = params[:race][:name]
    race.description = params[:race][:description]
    race.weights = params[:race][:weights]
    race.stakes = params[:race][:stakes]
    race.hasOtherConditions = params[:race][:hasOtherConditions]
    race.needs_nomination = params[:race][:needs_nomination]
    race.status = params[:race][:status]
    race.purse = params[:race][:purse]
    race.max_field_size = params[:race][:max_field_size]
    race.race_type = params[:race][:race_type]
      
    if(params[:category])
      race.category = 'Priority'
      if(params[:race_date] && !params[:race_date][:date].empty?)
        race_date = RaceDate.new       
        race_date.date = params[:race_date][:date]
        race.race_date = race_date
      end
    else
      race.category = 'Alternate'
    end

    return race
  end

  def update_status
    race = Race.find(params[:id])
    race.status = params[:status]

    if race.status == 'Draft'
      race.horseraces.delete_all
      race.tel = nil
    else
      addRaceToTEL(race)
    end

    race.save

    respond_to do |format|
      format.html { redirect_to :back, notice: 'Race was successfully updated.' }
    end
  end

  def horseList
    if (params[:trainer_id] === '0')
      @trainer = User.new(:name => 'No Trainer')
    else
      @trainer = User.find_by_id(params[:trainer_id])
    end
    
    @inactive = Status.find_by_name('Inactive')

    if @trainer
      @horses = Horse.where(:trainer_id => @trainer.id).where.not(:status => @inactive)

      all_horses = Horse.all

      all_horses.each do |horse|
        if horse.trainer_id
          user = User.find_by_id(horse.trainer_id)
          if !user
            @horses.push(horse)
          end
        end
      end
    else
      @horses = Array.new
    end

    if params[:horse_id]
      horse = Horse.find_by_id(params[:horse_id])

      if horse
        @horse = horse
      end
    end
    
    respond_to do |format|
      format.js
    end
  end

  def add_winner
    new_winner = RaceWinner.new(:race_title => params[:race_title], :horse_id => params[:horse_id])

    race = Race.find_by_id(params[:race_id])
    if race && race.tel
      date = race.tel.date
    else
      date = Date.today
    end

    horse_race = Horserace.where(:race_id => params[:race_id], :horse_id => params[:horse_id])
    horse_race[0].status = 'WON'
    horse_race[0].save

    @horse = Horse.find_by_id(params[:horse_id])

    if @horse
      @horse.wins += 1

      if @horse.horse_filter_setting
        @horse.horse_filter_setting.wins_id = nil
        @horse.horse_filter_setting.save
      end

      @horse.save
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

    horse = Horse.find_by_id(params[:horse_id])
    horse.status = Status.find_by_name('Race Ready')
    horse.save

    notification = Notification.find_or_create_by!(send_id: params[:race_id], recv_id: params[:horse_id], action: "Scratched")
    notification.save

    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  def resetHorseStatuses
    race_ready = Status.find_by_name('Race Ready')
    @race.horses.each do |horse|
      horse_race = Horserace.where(:race_id => @race.id, :horse_id => horse.id)
      if horse.status.name == 'Running'
        horse.status = race_ready
      end
      if horse_race[0].status != 'Scratched'
        horse.starts += 1
      end

      horse.save
    end

    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  def removeConfirmedHorses
    @race.horseraces.each do |horserace|
      if horserace.status == 'Confirmed' || horserace.status == 'WON'
        horserace.status = ''
      elsif horserace.status == 'Scratched'
        horserace.status = 'Interested'
      end

      horserace.save
    end

    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  def addRaceToTEL(race)
    if race.race_date && race.race_date.date && race.status == "Published"
      tel = Tel.where(:date => race.race_date.date, :entry_list => false).first
      race.tel = tel
    else
      race.tel = nil
    end

    race.save
  end

  def duplicate_race
    @race.duplicateRace

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
      params.require(:race).permit(:name, :created_at, :updated_at, :race_number, :description, :weights, :race_datetime, :winner, :claiming_purse, :status, :send_id, :recv_id, :race_id, :horse_id, :action, :claiming_level, :upper_claiming, :lower_claiming,:age_id, :wins, :distance, :category, :distance_type, :max_field_size, :purse, :race_type, :stakes, :hasOtherConditions, :condition_node_id, :race_title, :needs_nomination, :condition_ids => [])
    end
end
