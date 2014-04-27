class HorseConditionsController < ApplicationController
  before_action :set_horse_condition, only: [:show, :edit, :update, :destroy]

  # GET /horse_conditions
  # GET /horse_conditions.json
  def index
    if current_user.admin?
      @horse_conditions = HorseCondition.all
    elsif current_user.trainer?
      @horses = Horse.where(:trainer_id => current_user.id)
      @horse_conditions = HorseCondition.where(:horse => @horses)
    else
      @horses = Horse.where(:owner_id => current_user.id)
      @horse_conditions = HorseCondition.where(:horse => @horses)
    end
    
  end

  # GET /horse_conditions/1
  # GET /horse_conditions/1.json
  def show
  end

  # GET /horse_conditions/new
  def new
    @horse_condition = HorseCondition.new
    if current_user.admin?
      @horses = Horse.all
    elsif current_user.trainer?
      @horses = Horse.where(:trainer_id => current_user.id)
    else
      @horses = Horse.where(:owner_id => current_user.id)
    end
    @conditions = Condition.all
  end

  # GET /horse_conditions/1/edit
  def edit
    if current_user.admin?
      @horses = Horse.all
    elsif current_user.trainer?
      @horses = Horse.where(:trainer_id => current_user.id)
    else
      @horses = Horse.where(:owner_id => current_user.id)
    end
    @conditions = Condition.all
  end

  # POST /horse_conditions
  # POST /horse_conditions.json
  def create
    @horse_condition = HorseCondition.new(horse_condition_params)

    respond_to do |format|
      if @horse_condition.save
        format.html { redirect_to horse_conditions_url, notice: 'Horse condition was successfully created.' }
        format.json { render action: 'show', status: :created, location: @horse_condition }
      else
        format.html { render action: 'new' }
        format.json { render json: @horse_condition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /horse_conditions/1
  # PATCH/PUT /horse_conditions/1.json
  def update
    respond_to do |format|
      if @horse_condition.update(horse_condition_params)
        format.html { redirect_to horse_conditions_url, notice: 'Horse condition was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @horse_condition }
      else
        format.html { render action: 'edit' }
        format.json { render json: @horse_condition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /horse_conditions/1
  # DELETE /horse_conditions/1.json
  def destroy
    @horse_condition.destroy
    respond_to do |format|
      format.html { redirect_to horse_conditions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_horse_condition
      @horse_condition = HorseCondition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def horse_condition_params
      params.require(:horse_condition).permit(:horse_id, :condition_id, :value)
    end
end
