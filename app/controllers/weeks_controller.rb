class WeeksController < ApplicationController
  before_action :set_week, only: [:show, :edit, :update, :destroy, :reset_races]

  def index
    @weeks = Week.all
  end

  def show
    @races = FilterRacesService.new.eligibleRacesForWeek(@week)
    @meet = Meet.find(@week.meet_id)
  end

  def new
    @week = Week.new
    @meet = Meet.find(week_params[:meet_id])
  end

  def edit
    @meet = Meet.find(week_params[:meet_id])
  end

  def create
    @week = Week.new(week_params)
    @meet = Meet.find(week_params[:meet_id])

    respond_to do |format|
      if @week.save
        format.html { redirect_to @meet, notice: 'Week was successfully created.' }
      end
    end
  end

  def update
    respond_to do |format|
      if @week.update(week_params)
        format.html { redirect_to @week, notice: 'Week was successfully updated.' }
        format.json { render :show, status: :ok, location: @week }
      else
        format.html { render :edit }
        format.json { render json: @week.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @week.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  def reset_races
    @week.tels.each do |tel|
      tel.races.each do |race|
        race.horseraces.delete_all
      end
    end

    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  private
    def set_week
      @week = Week.find(params[:id])
    end

    def week_params
      params.require(:week).permit(:week_id, :meet_id, :week_number, :start_date, :end_date)
    end
end
