class ConditionsController < ApplicationController
  before_action :set_condition, only: [:show, :edit, :update, :destroy]

  # GET /conditions
  # GET /conditions.json
  def index
    @conditions = Condition.all
  end

  # GET /conditions/1
  # GET /conditions/1.json
  def show
  end

  # GET /conditions/new
  def new
    @condition = Condition.new
  end

  # GET /conditions/1/edit
  def edit
    @categories = Category.all
  end

  # POST /conditions
  # POST /conditions.json
  def create
    @condition = Condition.new(condition_params)
    @categories = Category.all

    respond_to do |format|
      if @condition.save
        format.html { redirect_to conditions_url, notice: 'Condition was successfully created.' }
        format.json { render action: 'index', status: :created, location: @conditions }
      else
        format.html { render action: 'new' }
        format.json { render json: @condition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conditions/1
  # PATCH/PUT /conditions/1.json
  def update
    respond_to do |format|
      if @condition.update(condition_params)
        format.html { redirect_to conditions_url, notice: 'Condition was successfully updated.' }
        format.json { render action: 'index', status: :ok, location: @conditions }
      else
        format.html { render action: 'edit' }
        format.json { render json: @condition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conditions/1
  # DELETE /conditions/1.json
  def destroy
    @condition.destroy
    respond_to do |format|
      format.html { redirect_to conditions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_condition
      @condition = Condition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def condition_params
      params.require(:condition).permit(:name, :category_id)
    end
end
