class PendingConditionsController < ApplicationController
  before_action :set_pending_condition, only: [:show, :edit, :update, :destroy, :approve]

  # GET /pending_conditions
  # GET /pending_conditions.json
  def index
    @pending_conditions = PendingCondition.all
  end

  # GET /pending_conditions/1
  # GET /pending_conditions/1.json
  def show
  end

  # GET /pending_conditions/new
  def new
    @pending_condition = PendingCondition.new
  end

  # GET /pending_conditions/1/edit
  def edit
  end

  # POST /pending_conditions
  # POST /pending_conditions.json
  def create
    @pending_condition = PendingCondition.new(pending_condition_params)

    respond_to do |format|
      if @pending_condition.save
        format.html { redirect_to @pending_condition, notice: 'Pending condition was successfully created.' }
        format.json { render :show, status: :created, location: @pending_condition }
      else
        format.html { render :new }
        format.json { render json: @pending_condition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pending_conditions/1
  # PATCH/PUT /pending_conditions/1.json
  def update
    respond_to do |format|
      if @pending_condition.update(pending_condition_params)
        format.html { redirect_to @pending_condition, notice: 'Pending condition was successfully updated.' }
        format.json { render :show, status: :ok, location: @pending_condition }
      else
        format.html { render :edit }
        format.json { render json: @pending_condition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pending_conditions/1
  # DELETE /pending_conditions/1.json
  def destroy
    if @pending_condition.action == "add"
      puts "DELETE"
      HorseCondition.where(:horse_id => @pending_condition.horse_id, :condition_id => @pending_condition.condition_id).delete_all
    else
      puts "CREATE"
      HorseCondition.find_or_create_by!(:horse_id => @pending_condition.horse_id, :condition_id => @pending_condition.condition_id)
    end

    @pending_condition.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Approval was successful' }
    end
  end

  def approve
    if @pending_condition.action == "remove"
      HorseCondition.where(:horse_id => @pending_condition.horse_id, :condition_id => @pending_condition.condition_id).delete_all
    end

    @pending_condition.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Approval was successful' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pending_condition
      @pending_condition = PendingCondition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pending_condition_params
      params[:pending_condition]
    end
end
