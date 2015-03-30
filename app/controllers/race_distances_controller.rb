class RaceDistancesController < ApplicationController
  before_action :set_race_distance, only: [:show, :edit, :update, :destroy]

  def index
    @race_distances = RaceDistance.all
    respond_with(@race_distances)
  end

  def show
    respond_with(@race_distance)
  end

  def new
    @race_distance = RaceDistance.new
    respond_with(@race_distance)
  end

  def edit
  end

  def create
    @race_distance = RaceDistance.new(race_distance_params)
    @race_distance.save
    respond_with(@race_distance)
  end

  def update
    @race_distance.update(race_distance_params)
    respond_with(@race_distance)
  end

  def destroy
    @race_distance.destroy
    respond_with(@race_distance)
  end

  private
    def set_race_distance
      @race_distance = RaceDistance.find(params[:id])
    end

    def race_distance_params
      params[:race_distance]
    end
end
