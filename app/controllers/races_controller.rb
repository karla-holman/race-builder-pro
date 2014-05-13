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
    @conditions = Condition.all
    @categories = Category.all
    @horseraces = Horserace.where("status = ? OR status = ? AND race_id = ?", "interested", "confirmed", @race.id)
    @current_conditions = RaceCondition.where(:race => @race)
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
      params.require(:race).permit(:name, :created_at, :updated_at, :race_number, :description, :race_datetime, :condition_ids => [])
    end
end
