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
    @categories = Category.all
  end

  # GET /conditions/1/edit
  def edit
    @categories = Category.all
  end

  # POST /conditions
  # POST /conditions.json
  def create
    @condition = Condition.new(condition_params)
    if condition_params[:name].empty?
      @condition.errors.add('Race condition', "must have a name.")
    end
    if condition_params[:category_id].empty?
      @condition.errors.add('Race condition', "must have a category.")
    end
    category = Category.find_by_id(condition_params[:category_id])
    if category
      @condition.category = category
    end

    if category && category.datatype == 'Value'
      @condition.lowerbound = nil
      @condition.upperbound = nil
      if params[:valueText].empty?
        @condition.errors.add('This race condition', "must have a value.")
      else
        @condition.value = params[:valueText]
      end
    elsif category && category.datatype == 'Range'
      if !condition_params[:needsDate] || condition_params[:needsDate] == "0"
        @condition.value = nil
      end
      if condition_params[:upperbound].empty? && condition_params[:lowerbound].empty?
        @condition.errors.add('This race condition', "must have either a lower or upper bound.")
      end
    end
    @categories = Category.all

    respond_to do |format|
       if @condition.errors.any?
        format.html { render action: 'new' }
        format.json { render json: @condition.errors, status: :unprocessable_entity }
      elsif @condition.save
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
    puts "TEST: " << condition_params.to_s
    puts "PARAMS: " << params.to_s
    @condition.name = condition_params[:name]
    @condition.upperbound = condition_params[:upperbound]
    @condition.lowerbound = condition_params[:lowerbound]
    @condition.value = condition_params[:value]
    @condition.needsDate = condition_params[:needsDate]

    if condition_params[:name].empty?
      @condition.errors.add('Race condition', "must have a name.")
    end
    if condition_params[:category_id].empty?
      @condition.errors.add('Race condition', "must have a category.")
    else
      @condition.category_id = condition_params[:category_id]
    end
    category = Category.find_by_id(condition_params[:category_id])
    if category
      @condition.category = category
    end

    if category && category.datatype == 'Value'
      if condition_params[:value].empty?
        @condition.errors.add('This race condition', "must have a value.")
      end
    elsif category && category.datatype == 'Range'
      if condition_params[:upperbound].empty? && condition_params[:lowerbound].empty?
        @condition.errors.add('This race condition', "must have either a lower or upper bound.")
      end
    end
    @categories = Category.all

    respond_to do |format|
      if @condition.errors.any?
        format.html { render action: 'edit' }
        format.json { render json: @condition.errors, status: :unprocessable_entity }
      elsif @condition.update(condition_params)
        if category && category.datatype == 'Range'
          if !condition_params[:needsDate] || condition_params[:needsDate] == "0"
            @condition.value = nil
            @condition.save
          end
        end
        if category && category.datatype == 'Value'
          if !condition_params[:value].empty?
            @condition.value = params[:valueText]
            @condition.save
          end
        end
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
      params.require(:condition).permit(:name, :category_id, :upperbound, :lowerbound, :value, :needsDate, :date)
    end
end
