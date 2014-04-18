class RaceConditionsController < ApplicationController
  before_action :set_race_condition, only: [:show, :edit, :update, :destroy]

  # GET /race_conditions
  # GET /race_conditions.json
  def index
    @race_conditions = RaceCondition.all
  end

  # GET /race_conditions/1
  # GET /race_conditions/1.json
  def show
  end

  # GET /race_conditions/new
  def new
    @race_condition = RaceCondition.new
    @races = Race.all
    @conditions = Condition.all
  end

  # GET /race_conditions/1/edit
  def edit
    @races = Race.all
    @conditions = Condition.all
  end

  # POST /race_conditions
  # POST /race_conditions.json
  def create
    @race_condition = RaceCondition.new(race_condition_params)

    respond_to do |format|
      if @race_condition.save
        format.html { redirect_to race_conditions_url, notice: 'Race condition was successfully created.' }
        format.json { render action: 'show', status: :created, location: @race_condition }
      else
        format.html { render action: 'new' }
        format.json { render json: @race_condition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /race_conditions/1
  # PATCH/PUT /race_conditions/1.json
  def update
    respond_to do |format|
      if @race_condition.update(race_condition_params)
        format.html { redirect_to race_conditions_url, notice: 'Race condition was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @race_condition }
      else
        format.html { render action: 'edit' }
        format.json { render json: @race_condition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /race_conditions/1
  # DELETE /race_conditions/1.json
  def destroy
    @race_condition.destroy
    respond_to do |format|
      format.html { redirect_to race_conditions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race_condition
      @race_condition = RaceCondition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def race_condition_params
      params.require(:race_condition).permit(:race_id, :condition_id, :value)
    end
end
