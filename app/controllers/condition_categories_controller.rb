class ConditionCategoriesController < ApplicationController
  before_action :set_condition_category, only: [:show, :edit, :update, :destroy]

  # GET /condition_categories
  # GET /condition_categories.json
  def index
    @condition_categories = ConditionCategory.all
  end

  # GET /condition_categories/1
  # GET /condition_categories/1.json
  def show
  end

  # GET /condition_categories/new
  def new
    @condition_category = ConditionCategory.new
  end

  # GET /condition_categories/1/edit
  def edit
  end

  # POST /condition_categories
  # POST /condition_categories.json
  def create
    @condition_category = ConditionCategory.new(condition_category_params)

    respond_to do |format|
      if @condition_category.save
        format.html { redirect_to @condition_category, notice: 'Condition category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @condition_category }
      else
        format.html { render action: 'new' }
        format.json { render json: @condition_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /condition_categories/1
  # PATCH/PUT /condition_categories/1.json
  def update
    respond_to do |format|
      if @condition_category.update(condition_category_params)
        format.html { redirect_to @condition_category, notice: 'Condition category was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @condition_category }
      else
        format.html { render action: 'edit' }
        format.json { render json: @condition_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /condition_categories/1
  # DELETE /condition_categories/1.json
  def destroy
    @condition_category.destroy
    respond_to do |format|
      format.html { redirect_to condition_categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_condition_category
      @condition_category = ConditionCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def condition_category_params
      params.require(:condition_category).permit(:name)
    end
end
