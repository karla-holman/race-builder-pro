class MeetsController < ApplicationController
  before_action :set_meet, only: [:show, :edit, :update, :destroy, :deactivate_horses]

  # GET /meets
  # GET /meets.json
  def index
    @meets = Meet.all
  end

  # GET /meets/1
  # GET /meets/1.json
  def show
    @weeks = @meet.weeks
  end

  # GET /meets/new
  def new
    @meet = Meet.new
  end

  # GET /meets/1/edit
  def edit
  end

  # POST /meets
  # POST /meets.json
  def create
    @meet = Meet.new(meet_params)
    
    if(!meet_params[:name] || meet_params[:name].empty?)
      @meet.errors.add('Meet name', "is missing")
    end

    if(!meet_params[:race_days] || meet_params[:race_days].empty?)
      @meet.errors.add('Number of race days', "is missing")
    end

    if(!meet_params[:start_date] || meet_params[:start_date].empty?)
      @meet.errors.add('Start date', "is missing")
    end

    if(!meet_params[:end_date] || meet_params[:end_date].empty?)
      @meet.errors.add('End date', "is missing")
    end

    respond_to do |format|
      if !@meet.errors.any? && @meet.save
        format.html { redirect_to @meet, notice: 'Meet was successfully created.' }
        format.json { render :show, status: :created, location: @meet }
      else
        format.html { render :new }
        format.json { render json: @meet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meets/1
  # PATCH/PUT /meets/1.json
  def update

    if(!meet_params[:name] || meet_params[:name].empty?)
      @meet.errors.add('Meet name', "is missing")
    end

    if(!meet_params[:race_days] || meet_params[:race_days].empty?)
      @meet.errors.add('Number of race days', "is missing")
    end

    if(!meet_params[:start_date] || meet_params[:start_date].empty?)
      @meet.errors.add('Start date', "is missing")
    end

    if(!meet_params[:end_date] || meet_params[:end_date].empty?)
      @meet.errors.add('End date', "is missing")
    end

    respond_to do |format|
      if !@meet.errors.any? && @meet.update(meet_params)
        format.html { redirect_to @meet, notice: 'Meet was successfully updated.' }
        format.json { render :show, status: :ok, location: @meet }
      else
        format.html { render :edit }
        format.json { render json: @meet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meets/1
  # DELETE /meets/1.json
  def destroy
    @meet.destroy
    respond_to do |format|
      format.html { redirect_to meets_url, notice: 'Meet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def deactivate_horses
    @inactive = Status.find_by_name('Inactive')

    Horse.all.each do |horse|
        horse.status = @inactive
        horse.save
    end

    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  def reset_races
    Race.all.each do |race|
      race.horseraces.delete_all
    end

    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meet
      @meet = Meet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meet_params
      params[:meet].permit(:name, :start_date, :end_date, :race_days)
    end
end
