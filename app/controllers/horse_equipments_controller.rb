class HorseEquipmentsController < ApplicationController
  before_action :set_horse_equipment, only: [:show, :edit, :update, :destroy]

  def index
    @horse_equipments = HorseEquipment.all
    respond_with(@horse_equipments)
  end

  def show
    respond_with(@horse_equipment)
  end

  def new
    @horse_equipment = HorseEquipment.new
    respond_with(@horse_equipment)
  end

  def edit
  end

  def create
    @horse_equipment = HorseEquipment.new(horse_equipment_params)
    @horse_equipment.save
    respond_with(@horse_equipment)
  end

  def update
    @horse_equipment.update(horse_equipment_params)
    respond_with(@horse_equipment)
  end

  def destroy
    @horse_equipment.destroy
    respond_with(@horse_equipment)
  end

  private
    def set_horse_equipment
      @horse_equipment = HorseEquipment.find(params[:id])
    end

    def horse_equipment_params
      params[:horse_equipment]
    end
end
