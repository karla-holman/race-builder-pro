class EquipmentController < ApplicationController
  before_action :set_equipment, only: [:show, :edit, :update, :destroy]

  # GET /equipment
  # GET /equipment.json
  def index
    @equipment = Equipment.all
  end

  # GET /equipment/1
  # GET /equipment/1.json
  def show
  end

  # GET /equipment/new
  def new
    @equipment = Equipment.new
  end

  # GET /equipment/1/edit
  def edit
  end

  def create
    @equipment = Equipment.new(equipment_params)
    respond_to do |format|
      if @equipment.save
        format.html { redirect_to equipment_index_url, notice: 'Equipment / Medication was successfully created.' }
        format.json { render action: 'index', status: :created, location: @equipment }
      else
        format.html { render action: 'new' }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @equipment.update(equipment_params)
        format.html { redirect_to equipment_index_url, notice: 'Equipment / Medication was successfully updated.' }
        format.json { render action: 'index', status: :ok, location: @equipment }
      else
        format.html { render action: 'edit' }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @equipment.destroy
    respond_to do |format|
      format.html { redirect_to equipment_index_url }
      format.json { head :no_content }
    end
  end

  private
    def set_equipment
      @equipment = Equipment.find(params[:id])
    end

    def equipment_params
      params[:equipment]
      params.require(:equipment).permit(:name, :required)
    end
end

