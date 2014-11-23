class RaceDatesController < ApplicationController
  before_action :set_race_date, only: [:show, :edit, :update, :destroy]

  def index
    @race_dates = RaceDate.all
    respond_with(@race_dates)
  end

  def show
    respond_with(@race_date)
  end

  def new
    @race_date = RaceDate.new
    respond_with(@race_date)
  end

  def edit
  end

  def create
    @race_date = RaceDate.new(race_date_params)
    @race_date.save
    respond_with(@race_date)
  end

  def update
    @race_date.update(race_date_params)
    respond_with(@race_date)
  end

  def destroy
    @race_date.destroy
    respond_with(@race_date)
  end

  private
    def set_race_date
      @race_date = RaceDate.find(params[:id])
    end

    def race_date_params
      params[:race_date]
    end
end
