class HorseracesController < ApplicationController
  before_action :set_horserace, only: [:show, :edit, :update, :destroy]
  skip_before_filter  :verify_authenticity_token

  # GET /horseraces
  # GET /horseraces.json
  def index
    @horseraces = Horserace.all
  end

  # GET /horseraces/1
  # GET /horseraces/1.json
  def show
  end

  # GET /horseraces/new
  def new
    @horserace = Horserace.new
    @horses = Horse.all
    @races = Race.all
  end

  # GET /horseraces/1/edit
  def edit
    @horses = Horse.all
    @races = Race.all
  end

  # POST /horseraces
  # POST /horseraces.json
  def create
    @horserace = Horserace.new(horserace_params)

    if horserace_params[:status] == 'Confirmed'
      @horse.horseraces.where(:status => 'Confirmed').each do |horserace|
        horserace.status = 'Interested'
        horserace.save
      end
    end
    
    respond_to do |format|
      if @horserace.save
        format.html { redirect_to horseraces_url, notice: 'Horserace was successfully created.' }
        format.json { render action: 'index', status: :created, location: @horseraces }
      else
        format.html { render action: 'new' }
        format.json { render json: @horserace.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /horseraces/1
  # PATCH/PUT /horseraces/1.json
  def update
    @horse = Horse.find(@horserace.horse_id)
    @race = Race.find(@horserace.race_id)

    if horserace_params[:status] == 'Confirmed'
      @confirmed = Horserace.where(:horse_id => @horserace.horse_id, :status => 'Confirmed')
      @confirmed.each do |horserace|
          horserace.status = 'Interested'
          horserace.save
      end
    end

    respond_to do |format|
      if @horserace.status == 'Confirmed' && horserace_params[:status].empty?
        @horserace.status = 'Interested'
        @horserace.save
        status = @horserace.status
      elsif @horserace.update(horserace_params)
        if (@horserace.status.empty?)
          status = "Uninterested"
        else
          status = @horserace.status
        end
        @horse.create_activity :raceStatus, parameters: {status: status, race_id: @race.id}, owner: current_user
        if request.xhr?
          @horseraces = Horserace.all
          format.html { render action: 'index' }
        else
          format.html { redirect_to horseraces_url, notice: 'Horserace was successfully updated.' }
          format.json { render action: 'index', status: :ok, location: @horseraces }
        end
      else
        format.html { render action: 'edit' }
        format.json { render json: @horserace.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirmHorse
    horse_id = params[:horse_id]
    race_id = params[:race_id]

    if horse_id && race_id
      horserace = Horserace.find_or_create_by(:horse_id => horse_id, :race_id => race_id)
      horserace.status = "Confirmed"
      horserace.save
    end

    redirect_to :back
  end



  # DELETE /horseraces/1
  # DELETE /horseraces/1.json
  def destroy
    @horserace.destroy
    respond_to do |format|
      format.html { redirect_to horseraces_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_horserace
      @horserace = Horserace.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def horserace_params
      params.require(:horserace).permit(:horse_id, :race_id, :entered, :status, :created_at, :updated_at)
    end
end
