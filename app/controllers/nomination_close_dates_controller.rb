class NominationCloseDatesController < ApplicationController
  before_action :set_nomination_close_date, only: [:show, :edit, :update, :destroy]

  def index
    @nomination_close_dates = NominationCloseDate.all
    respond_with(@nomination_close_dates)
  end

  def show
    respond_with(@nomination_close_date)
  end

  def new
    @nomination_close_date = NominationCloseDate.new
    respond_with(@nomination_close_date)
  end

  def edit
  end

  def create
    @nomination_close_date = NominationCloseDate.new(nomination_close_date_params)
    @nomination_close_date.save
    respond_with(@nomination_close_date)
  end

  def update
    @nomination_close_date.update(nomination_close_date_params)
    respond_with(@nomination_close_date)
  end

  def destroy
    @nomination_close_date.destroy
    respond_with(@nomination_close_date)
  end

  private
    def set_nomination_close_date
      @nomination_close_date = NominationCloseDate.find(params[:id])
    end

    def nomination_close_date_params
      params[:nomination_close_date]
    end
end
