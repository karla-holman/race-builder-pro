class LastWinsController < ApplicationController
  before_action :set_last_win, only: [:show, :edit, :update, :destroy]

  def index
    @last_wins = LastWin.all
    respond_with(@last_wins)
  end

  def show
    respond_with(@last_win)
  end

  def new
    @last_win = LastWin.new
    respond_with(@last_win)
  end

  def edit
  end

  def create
    @last_win = LastWin.new(last_win_params)
    @last_win.save
    respond_with(@last_win)
  end

  def update
    @last_win.update(last_win_params)
    respond_to do |format|
        format.html { redirect_to :back }
      end
  end

  def destroy
    @last_win.destroy
    respond_with(@last_win)
  end

  private
    def set_last_win
      @last_win = LastWin.find(params[:id])
    end

    def last_win_params
      params[:last_win].permit(:date, :distance, :distance_type, :money_earned)
    end
end
