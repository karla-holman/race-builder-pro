class HorseMeetsController < ApplicationController
  before_action :set_horse_meet, only: [:show, :edit, :update, :destroy]

  # GET /horse_meets
  # GET /horse_meets.json
  def index
    @horse_meets = HorseMeet.all
  end

  # GET /horse_meets/1
  # GET /horse_meets/1.json
  def show
  end

  # GET /horse_meets/new
  def new
    @horse_meet = HorseMeet.new
  end

  # GET /horse_meets/1/edit
  def edit
  end

  # POST /horse_meets
  # POST /horse_meets.json
  def create
    @horse_meet = HorseMeet.new(horse_meet_params)

    respond_to do |format|
      if @horse_meet.save
        format.html { redirect_to @horse_meet, notice: 'Horse meet was successfully created.' }
        format.json { render :show, status: :created, location: @horse_meet }
      else
        format.html { render :new }
        format.json { render json: @horse_meet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /horse_meets/1
  # PATCH/PUT /horse_meets/1.json
  def update
    respond_to do |format|
      if @horse_meet.update(horse_meet_params)
        format.html { redirect_to @horse_meet, notice: 'Horse meet was successfully updated.' }
        format.json { render :show, status: :ok, location: @horse_meet }
      else
        format.html { render :edit }
        format.json { render json: @horse_meet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /horse_meets/1
  # DELETE /horse_meets/1.json
  def destroy
    @horse_meet.destroy
    respond_to do |format|
      format.html { redirect_to horse_meets_url, notice: 'Horse meet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_horse_meet
      @horse_meet = HorseMeet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def horse_meet_params
      params[:horse_meet]
    end
end
